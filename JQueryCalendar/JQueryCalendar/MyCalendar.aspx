<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyCalendar.aspx.cs" Inherits="JQueryCalendar.MyCalendar" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        table, td {
            border: 1px solid black;
            border-collapse: collapse;
        }    
        th {
            border: 1px solid red;
            width:14%;
            padding: 5px;
            font-family:Cambria;
        }
        td
        {   
            text-align:left;
            vertical-align:top;
            padding-top:10px;
            padding-left:5px;
        }
        
        #popupdiv
        {
            width: 350px;
            height: 200px;
            border: 1px Solid green;
            background-color:White;
            }
    </style>

    <script src="Scripts/jquery-2.1.3.js" type="text/javascript"></script>
    <script type="text/javascript">
        
        var monthArray = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        var dayArray = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        var showPopupWindow = "false";

        $(document).ready(function () {
            $("#tblCalendar").on('click', 'td', function (e) {
                if ($(this).text() != '') {
                    if (showPopupWindow == "false") {

                        $('#txtSaveMonth').val($('#hdnMonthNumber').val());
                        $('#txtSaveYear').val($('#hdnYear').val());
                        $('#txtSaveDay').val($(this).text());
                        showPopupWindow = "true";
                        $("#popupdiv").show();
                        $("#popupdiv").offset({ left: e.pageX, top: e.pageY });
                    }
                }
            });

            $('#btnSave').click(function () {
                showPopupWindow = "false";



                $('#txtSaveMonth').val('');
                $('#txtSaveYear').val('');
                $('#txtSaveDay').val('');
                $('#txtDescription').val('');
                $("#popupdiv").css("display", "none");
            });

            PopulateCurrentMonth();

            var dt = new Date();

            $('#btnPreviousMonth').click(function () {
                if ($('#hdnMonthNumber').val() == "0") {
                    $('#hdnMonthNumber').val("11");
                    $('#hdnYear').val($('#hdnYear').val() - 1);
                }
                else {
                    $('#hdnMonthNumber').val(parseInt($('#hdnMonthNumber').val()) - 1);
                }

                var currentYear = $('#hdnYear').val();
                var currentMonth = $('#hdnMonthNumber').val();

                var numberOfDaysInMonth = new Date(currentYear, parseInt(currentMonth) + 1, 0).getDate();

                var currentMonthYear = monthArray[currentMonth] + ' ' + currentYear;
                $('#MonthYear').text(currentMonthYear);

                CreateCalendar(currentYear, currentMonth, numberOfDaysInMonth);
            });

            $('#btnNextMonth').click(function () {
                if ($('#hdnMonthNumber').val() == "11") {
                    $('#hdnMonthNumber').val("0");
                    $('#hdnYear').val(parseInt($('#hdnYear').val()) + 1);
                }
                else {
                    $('#hdnMonthNumber').val(parseInt($('#hdnMonthNumber').val()) + 1);
                }

                var currentYear = $('#hdnYear').val();
                var currentMonth = $('#hdnMonthNumber').val();

                var numberOfDaysInMonth = new Date(currentYear, parseInt(currentMonth) + 1, 0).getDate();

                var currentMonthYear = monthArray[currentMonth] + ' ' + currentYear;
                $('#MonthYear').text(currentMonthYear);

                CreateCalendar(currentYear, currentMonth, numberOfDaysInMonth);
            });
        });

        function PopulateCurrentMonth() {
            var currentdate = new Date();
            var currentMonth = currentdate.getMonth();
            var currentYear = currentdate.getFullYear();
            var currentMonthYear = monthArray[currentMonth] + ' ' + currentYear;
            $('#hdnMonthNumber').val(currentMonth);
            $('#hdnYear').val(currentYear);
            $('#MonthYear').text(currentMonthYear);

            //No Of Days in Month
            var numberOfDaysInMonth = new Date(currentdate.getFullYear(), currentdate.getMonth()+1, 0).getDate();

            CreateCalendar(currentYear, currentMonth, numberOfDaysInMonth);
        }

        function CreateCalendar(currentYear, currentMonth, numberOfDaysInMonth) {

            var noOfRows = 6;
            var noOfColumns = 7;
            var htmlRowCol;

            var DaysCounter = 1;
            htmlRowCol = "<tr>";

            $('#tblCalendar').find("tr:gt(0)").remove();

            for (var row = 1; row <= noOfRows; row++) {
                if (row > 1) {
                    htmlRowCol += "<tr>";
                }
                for (var col = 0; col <= noOfColumns - 1; col++) {
                    if (dayArray[col] == dayArray[new Date(currentYear, currentMonth, DaysCounter).getDay()]) {
                        if (DaysCounter <= numberOfDaysInMonth) {
                            htmlRowCol += "<td>" + DaysCounter + "</td>";
                            DaysCounter += 1;
                        }
                        else {
                            htmlRowCol += "<td></td>";
                        }
                    }
                    else {
                        htmlRowCol += "<td></td>";
                    }
                }
                htmlRowCol += "</tr>";
            }

            $('#tblCalendar').append(htmlRowCol);
            $("#tblCalendar td").css("height", "80px");
            $("#tblCalendar td").css("text-align", "left");
            $("#tblCalendar td").css("vertical-align", "top");
            $("#tblCalendar td").css("padding-top", "10px");
            $("#tblCalendar td").css("padding-left", "5px");
        }
    </script>
</head>


<body>
    <form id="form1" runat="server">
    <div>

    <input type="hidden" id="hdnMonthNumber" /><input type="hidden" id="hdnYear" />
    <table width="100%" style="border:0px solid green"> <!--style="border:1px solid green;" frame="box"-->
        <tr>
            <td width="6%" style="vertical-align:middle;padding-bottom:10px;border:0px;"><input type="button" id="btnPreviousMonth" value="<" style="font-weight:bolder;font-size:large;" /><input type="button" id="btnNextMonth" value=">" style="font-weight:bolder;font-size:large;"/></td>
            <td style="vertical-align:middle;padding-bottom:10px;font-family:Ebrima;font-size:20px;font-weight:bold;;border:0px;"><span id="MonthYear"/></td>
        </tr>
    </table>
    <table width="100%" style="border:1px solid black;border-collapse: collapse;" id="tblCalendar">
        <tr>
            <th>Sunday</th>
            <th>Monday</th>
            <th>Tuesday</th>
            <th>Wednesday</th>
            <th>Thursday</th>
            <th>Friday</th>
            <th>Saturday</th>
        </tr>
<%--        <tr>
            <td style="height:100px;">1</td>
            <td>2</td>
            <td>3</td>
            <td>4</td>
            <td>5</td>
            <td>6</td>
            <td>7</td>
        </tr>
        <tr>
            <td style="height:100px;">8</td>
            <td>9</td>
            <td>10</td>
            <td>11</td>
            <td>12</td>
            <td>13</td>
            <td>14</td>
        </tr>
        <tr>
            <td style="height:100px;">15</td>
            <td>16</td>
            <td>17</td>
            <td>18</td>
            <td>19</td>
            <td>20</td>
            <td>21</td>
        </tr>
        <tr>
            <td style="height:100px;">22</td>
            <td>23</td>
            <td>24</td>
            <td>25</td>
            <td>26</td>
            <td>27</td>
            <td>28</td>
        </tr>
        <tr>
            <td style="height:100px;">29</td>
            <td>30</td>
            <td>31</td>
            <td>32</td>
            <td>33</td>
            <td>34</td>
            <td>35</td>
        </tr>--%>
    </table>
    </div>

    <div id="popupdiv" title="Basic modal dialog" style="display: none">
        <table style="border:none;">
            <tr>
                <td style="border:none;"><input type="hidden" id="txtSaveMonth" /></td><td style="border:none;"><input type="hidden" id="txtSaveYear" /></td>
            </tr>
            <tr>
                <td colspan="2" style="border:none;"><input type="hidden" id="txtSaveDay" /></td>
            </tr>
            <tr>
                <td style="text-align:center;padding-bottom:10px;border:none">Description</td><td style="text-align:center;padding-bottom:10px;border:none"><input type="text" id="txtDescription" /></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;padding-bottom:10px;;border:none" ><input type="button" id="btnSave" value="Save" style="width:100px;" /></td>
            </tr>
        </table>
    </div>

    </form>
</body>
</html>
