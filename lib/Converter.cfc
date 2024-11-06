component Converter
    output = false
    hint = "Helper function for converting a query data type to JSON"
    {

        public array function queryToArray(required query queryData) {
            var columns = listToArray(arguments.queryData.ColumnList);

            data = ArrayNew(1);

            for (rowIndex = 1; rowIndex <= arguments.queryData.RecordCount; rowIndex++) {
                datum = structNew();

                for (columnIndex = 1; columnIndex <= arrayLen(columns); columnIndex++) {
                    columnName = columns[columnIndex];
                    datum[columnName] = arguments.queryData[columnName][rowIndex];
                }

                arrayAppend(data, datum);
            }

            return data;
        }
}