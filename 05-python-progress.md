==================================================  
"Every complex architecture begins with a single line of clean code."    
PROJECT: Data Stack Integration with Python



Learning progress, best practices and code examples:
1. Syntax, data structures, resources and code best practices.  
2. Training: The Complete Python Bootcamp From Zero to Hero in Python, progress: (26 of 170 completed)
  - #official repositories provided by the course instructor
  - https://github.com/Pierian-Data/Complete-Python-3-Bootcamp.git
3. Training: Hands-on challenge with "stratascratch.com" Python path with Pandas library, progress: (11% completed).
  - #direct link to the training:
  - https://www.stratascratch.com/learn/comprehensive-python  

==================================================

1.001    
    # "code is read much more often than it is written", “readability counts”  
  - Official PEP 8 coding style guidelines and industry standards for clean Python code:  
  - https://python.org/pep-0008/

2.022   
    # String properties and methods
  - comments in python start with #
  - carefull when string exists in int column cause it supports addition and mutiplication
  - x.+tab - methods for the string
  - x.split('i') i = list with example letter to split on
2.024   
    # string interpolation - variable into string
  - .format() print('string {}'.format('INSERTED')) = "string INSERTED"
  - .format() index positions and keywords ex. print('string {1} {a}'.format(a='str0','str1'))
  - float formatting "{value:width.precision f}"
  - ex. print("The result{r:1.3f}".format(r=result))
  - newer method: print(f'{name} is {age} years old.') as of python 3.6
  - https://pyformat.info/ #string formatting documentation 
2.026   
    # lists
  - 

3.001   
    # Python & Pandas
  - import pandas as pd
  - df = pd.read_csv("file.csv"), .read_excel, .read_json;
  - df = pd.read_sql("SELECT * FROM table", connection);
  - df = df[["column1","column2"]], df - whole table;
  - df['col'] Seriex, df[['col']] DataFrame
  - df.head(), df.tail();
  - df.shape #rows and columns, df.columns, df.dtypes, 
  - df.info() #columns, types, non-null counts
  - dtype strings (object in pandas)
  - df.describe() #numeric columns summary, df.describe(include='all')

3.002    
    # working with columns
  - df.rename(columns={
      "first_col": "first col descr",
      "nxt_col": "nxt col descr"
    })
  - df = df.rename(...) #stored for later    
  - df["col_calc"] = df["col"] /x # arithmetic operators: + - * /
  - df["combined_text"] = (
      df["text1"] + " " + df["text2"]
    )
  - .astype(str): df["id"].astype(str) + " - " + df["name"] #numeric column int string
  - df[["col"]].drop_duplicates(), #multiple columns, combination checked
  - df['col'].unique() #NumPy array of unique val
  - dtypes #object, int64, float64, datetime64, bool
  --# numeric - carefull with "N/A" or "$1,200"

3.003    
    # filtering
  - condition =  df["col"] == "object", result syntax: df[condition] #boolean indexing  
  - single line syntax: df[df["col"] == "object"]
  - numeric >,<,>=,<=,!=
  - syntax df.loc[condition,["col1","col2"]] 
  - df["name"].str.startswith("object"), .contains("object"), .endswith("object")
  - df["name"].str.lower().str.startswith("object") # case sensitive handling
  - df[df['text'].str.contains(".", regex=False)] #handling: "." any character, "$" - string end
  - multi condition: df[(condition1) & (condition2)],  and: "&", or: "|", not "~"

3.004    
    # combining conditions
  - multi condition: df[(condition1) & (condition2)] #conditions in () when calc inside df
  - .loc locmulti argument filter syntax df.loc[cond1 & cond2, ["col1","col2"]]
  - df_short = data_frame_long_name
  - .isin df[df["column_name"].isin(["object1", "object2"])] #.isin multi object "|" condition
  - .isin does not accept <=, >= inside the statement
  - df.loc[condition,["col2"]] #remember about [] to avoid index display
  - .between used with inclusive="right", "left", "both"
  - .between df["col"].between(int1, int2) ex: orders[orders["total_order_cost"].between(50, 200, inclusive="right")
  - .between with dates .between("yyyy-mm-dd", "yyyy-mm-dd")
  - negation ~ and !
  - "/" and "(" #() - better to keep the code readable and move to next row with indentation
  - condition = (
      df["col"].isin(["object1","object2"])
    )
  - "and" and "or" work on single True/False, for filtering use &/|
  - "&" is evaluated before "|"




