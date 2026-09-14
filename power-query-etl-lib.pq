
/*
==================================================
PROJECT: POWER QUERY SOLUTIONS APPROACH EXAMPLES
Date: 2026

M Practise Approach and code examples:
1. Multi File transformation in single ETL step, load time optimization
2. 
==================================================
*/

--#1: multi source file integration in one ETL PQ step, sharepoint data refresh decrease 

let
--// Static site URL (refreshable)
    SiteURL = "https://iweof.sharepoint.com/teams/o365g_sharepoint_name",
--// Get all files from SharePoint
    AllFiles = SharePoint.Files(SiteURL, [ApiVersion = 15]),
 
--// Filter sharepoint immediately to reduce load
    FinalFolderFiles = Table.SelectRows(AllFiles, each 
        Text.Contains([Folder Path], "Dedicated_Folder/Subfolder/FY26/") and 
        Text.EndsWith([Name], ".xlsx")
    ),

--// Define the folder path to filter
    TargetFolder = "https://iweof.sharepoint.com/teams/o365g_sharepoint_name/Shared Documents/Dedicated_Folder/Subfolder/FY26/",


--// Define file list and CATEGORIESs as records with consistent field names
    FileList = {
        [fileName = "FY26 Product Related Services Category One.xlsx", lvl1 = "PRS_Category_One"],
        [fileName = "FY26_PRS_Cat2.xlsx", lvl1 = "PRS_Two"],
        [fileName = "FY26_PRS_Cat3.xlsx", lvl1 = "PRS_Next"]
        		},

SheetNames = {"IncludedSheetName1",//"ExcludedSheetName1b","ExcludedSheetName1c",
"IncludedSheetName2",//"ExcludedSheetName2b","ExcludedSheetName2c",
"IncludedSheetNameNext"},
         
--// Process ONE file using original steps (no existence checks)
    ProcessFile = (fileName as text, lvl1 as any) =>

        let
            FileRow = Table.SelectRows(AllFiles, each Text.StartsWith([Folder Path], TargetFolder) and [Name] = fileName),
            FileBinary = FileRow{0}[Content],
            ExcelData = Excel.Workbook(FileBinary, null, true),
            ProcessSheet = (sheetName as text) =>
                let
                    RawSheet = ExcelData{[Item=sheetName, Kind="Sheet"]}[Data],
                    LimitedRows = Table.FirstN(RawSheet, 2000),

    #"First Step" = Table.TransformColumnTypes(#"RawSheet",{{"Column1", type text}, {"Column2", type text}, {"Column17", type any}}),
--// Further Power Query steps for each worksheet

    #"FinalStep" = Table.AddColumn(#"Added Custom2", "ColumnName", each lvl1)
		in
    #"FinalStep",

	        CombinedSheets = List.Transform(SheetNames, each ProcessSheet(_)),
            FinalTable = Table.Combine(CombinedSheets),
            #"Filtered Rows" = Table.SelectRows(FinalTable, each true),
            #"Filtered Rows1" = Table.SelectRows(#"Filtered Rows", each true)
        in
            #"Filtered Rows1",
          
--// Process selected files and append
    ProcessedTables = List.Transform(FileList, each ProcessFile([fileName], [lvl1])),
   

    Output = Table.Combine(ProcessedTables),

--// Further Power Query M transformations of compbined files 

    #"Removed Columns1" = Table.RemoveColumns(Output,{"Column1", "Column2", "ColumnNext"}),
    #"FinalStepCombined" = Table.TransformColumnTypes(#"Grouped Rows",{{"Monthly_FC_FFO_Key", type text}})
in
    #"FinalStepCombined"