CREATE TRIGGER aftD_UpdateReports
 after delete on History begin update Reports 
set Credit = Credit - old.Credit, Dues = Dues + old.Credit where Date_Month = old.RecordMonth; end

CREATE TRIGGER aft_insertAccounts 
after insert on CustomerAccounts
 begin insert into History(NUID, RecordMonth,Balance,Credit,Dues,CreditDate,Plan)
 values(new.Acc_NUID, (select case strftime('%m', date('now')) when '01' then 'January,' when '02' then 'Febuary,' when '03' then 'March,' when '04' then 'April,' when '05' then 'May,' when '06' then 'June,' when '07' then 'July,' when '08' then 'August,' when '09' then 'September,' when '10' then 'October,' when '11' then 'November,' when '12' then 'December,' else '' end || " " || strftime('%Y', date('now')) as RecordMonth) , new.Dues, 0, new.Dues, strftime('%d-%m-%Y %H:%M:%S','now'),new.Plan ); end
 
 CREATE TRIGGER aft_updateAccounts after update on CustomerAccounts when new.Credit-old.credit > 0 begin insert into History(NUID, RecordMonth,Balance,Credit,Dues,CreditDate,Plan) values(old.Acc_NUID, (select case strftime('%m', date('now')) when '01' then 'January,' when '02' then 'Febuary,' when '03' then 'March,' when '04' then 'April,' when '05' then 'May,' when '06' then 'June,' when '07' then 'July,' when '08' then 'August,' when '09' then 'September,' when '10' then 'October,' when '11' then 'November,' when '12' then 'December,' else '' end || " " || strftime('%Y', date('now')) as RecordMonth) , old.Dues, old.Dues-new.Dues, new.Dues, strftime('%d-%m-%Y %H:%M:%S','now'),new.Plan ); end