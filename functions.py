import subprocess as sp
import pymysql
import pymysql.cursors

def show(table_name):
    """If ch==0 selects all values from table, if 1 then selects a certain row only."""

    try:
        cmd = "SELECT * from "
        cmd+=table_name
        cur.execute(cmd)
        
    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>",e)

    else:
        result=cur.fetchall()
        for i in result:
            print(i)

    return

def insert(table_name):
    """Inserts record into Table table_name """
    try:
        insert_cmd="INSERT INTO "
        # print(insert_cmd)
        insert_cmd+=str(table_name)
        get_all_cmd="SELECT * from "
        get_all_cmd+=table_name
        cur.execute(get_all_cmd)
        title=[i[0] for i in cur.description]
        print("If no value for a paricular attricute and NULL values are allowed, then type in 'NULL'.")
        insert_cmd+=(" (")
        for i in range(len(title)):
            insert_cmd+=title[i]
            if i != len(title) -1:
                insert_cmd+=", "
        insert_cmd+=") "
        insert_cmd+="VALUES ("
        for i in range(len(title)):
            # print("i:",i)
            inp=str(input("Value for attribute %s is:"%(title[i])))
            insert_cmd+=" "
            # insert_cmd+=title[i]
            insert_cmd+= "\'" + inp + "\'"
            if i != len(title)-1:
                insert_cmd+=","
        insert_cmd+=");"
        # print("TEST:",insert_cmd)
        try:
            cur.execute(insert_cmd)
            con.commit()
        except Exception as e:
            # print("Invalid Command! Datatype mismatch!")
            print("Error>>>",e)
    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>",e)

def update(table_name,param,val,cond_attr,cond_val):
    try:
        update_cmd="UPDATE "
        update_cmd+=table_name
        update_cmd+=" SET "
        for i in range(len(param)):
            update_cmd+=str(param[i])
            update_cmd+=" = "
            update_cmd+="\'"+str(val[i])+"\'"
            if(i != len(param)-1):
                update_cmd+=","
            update_cmd+=" "
        update_cmd+="WHERE "
        for i in range(len(cond_attr)):
            update_cmd+=cond_attr[i]
            update_cmd+=" = "
            update_cmd+=cond_val[i]
            if(i!=len(cond_attr)-1):
                update_cmd+=" AND "
        print(update_cmd)
        cur.execute(update_cmd)
        con.commit()
    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>",e)

def delete(table_name,param,cond):
    """Deletes the row with param[i]=cond[i] for all i"""
    try:
        print("Deletes the record if the primary key matches a particular value")
        delete_cmd="DELETE from "
        delete_cmd+=table_name
        delete_cmd+=" WHERE "
        # primary_key=cur.execute("SHOW KEYS from table where Key_name = 'PRIMARY'")
        
        for i in range(len(param)):
            delete_cmd+=str(param[i])               # check!
            delete_cmd+=" = "
            delete_cmd+="\'"+str(cond[i])+"\'"
            if(i!=len(param)-1):
                delete_cmd+=" AND "
        print(delete_cmd)    
        cur.execute(delete_cmd)
        con.commit()
    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>",e)

def ShowOrder():
    show("online_food.Order")

def ShowPayments():
    show("Payment")

def AddCustomer():
    """Add a customer to the application"""
    table="Customer"
    # print("YESH")
    insert(table)
    print("Address table:")
    AddAddress()
    print("Email table:")
    AddEmail()

def AddAddress():
    insert("Address")

def HireEmployee():
    """Hire an employee by adding a record in table Employee"""
    insert("Employee")

def AddDependant():
    """Add a dependant """
    insert("Dependants")

def AddRestaurant():
    """Add a restaurant to the application"""
    insert("Restaurant")

def AddFeedback():
    """Add a feedback record"""
    insert("Feedback")

def AddCall():
    insert("Call")

def AddEmail():
    insert("Email")

def AddItem():
    insert("Item")

def PlaceOrder():
    """Places an order by adding a record in multiple tables: Payment, Order, Delivery. If possible, Load the dependents details as well"""
    Cust_ph=str(input("Enter the Customer Phone number:"))
    Ord_Id=str(input("Enter the unique Order ID:"))
    Rest_Id=str(input("Enter the restaurant ID:"))
    Prod_Name=str(input("Enter the product name:"))
    Prod_Qty=str(input("Enter the number of products of this product name:"))
    Method=input("Enter the Payment method(Net_Banking,COD(cash on delivery)):")
    Address=input("Enter the address to where you want the delivery:")
    # Rest_Id = 3
    # Prod_Name = "noodles"
    try:
        cmd="Select Cost from Item where REST_ID = "
        cmd+="\'"+str(Rest_Id)+"\'"
        cmd+=" AND ITEM_NAME = "
        cmd+="\'"+str(Prod_Name) +"\'"
        # print(cmd)
        cur.execute(cmd)
        Order_Cost=cur.fetchall()
        print(Order_Cost)
        Order_Cost=Order_Cost[0]['Cost']
        # for i in Order_Cost:
        #     print(i)
        #     x=Order_Cost[i]
        # Order_Cost=Order_Cost[0]
        print(Order_Cost)
        Prod_Cost=int(Order_Cost)*int(Prod_Qty)
        print("I AM NOT MAD!!")
        STAT="No"
        Ord_Id=int(Ord_Id)
        Order_Cost=int(Order_Cost)
        Prod_Qty=int(Prod_Qty)
        insert_cmd="Insert into online_food.Order (ORDER_ID, PRODUCT_COST,PRODUCT_QTY, PRODUCT_NAME, STATUS) VALUES("
        insert_cmd+="%d, " %(Ord_Id)
        insert_cmd+="%d, " %(Order_Cost)
        insert_cmd+="%d, "%(Prod_Qty)
        insert_cmd+="\'" + str(Prod_Name) + "\', "
        insert_cmd+="\'" + str(STAT) + "\' "
        insert_cmd+=")"
        print(insert_cmd)
        cur.execute(insert_cmd)
        print("I AM NOT MAD!!")
        # con.commit()

        insert_cmd="Insert into Payment (ORDER_ID, METHOD, PRODUCT_COST, STATUS) VALUES("
        insert_cmd+="%d, " %(Ord_Id)
        insert_cmd+="\'" + str(Method) + "\', "
        insert_cmd+="%d, " %(Prod_Cost)
        insert_cmd+="\'" + str(STAT) + "\' "
        insert_cmd+=")"
        print(insert_cmd)
        cur.execute(insert_cmd)
        print("I AM NOT MAD!!")
        # cur.commit()
    
        insert_cmd="Insert into Delivery (ORDER_ID, CASH_TO_COLLECT, CUSTOMER_ADDRESS, DELIVERY_PHONE, CUSTOMER_PHONE, REST_ID, STATUS) VALUES("
        if(Method == "COD"):
            Cash_to_Collect = Prod_Cost
        else:
            Cash_to_Collect = 0
        cmd="select PHONE_NO from Employee where TYPE = 'DELIVERY' "
        cur.execute(cmd)
        Deliv=cur['PHONE_NO'][0]
        insert_cmd+="\'" + str(Ord_Id) + "\', "
        insert_cmd+="\'" + str(Cash_to_Collect) + "\', "
        insert_cmd+="\'" + str(Address) + "\', "
        insert_cmd+="\'" + str(Deliv) + "\', "
        insert_cmd+="\'" + str(Cust_ph) + "\', "
        insert_cmd+="\'" + str(Rest_Id) + "\', "
        insert_cmd+="\'" + str(STAT) + "\' "
        insert_cmd+=")"
        cur.execute(insert_cmd)
        con.commit()

    except Exception as e:
        con.rollback()
        print("Unable to add record.")
        print("Error:",e)



def EditCustomerDetails():
    """Edit Customer's Details"""
    cond_val=input("Enter the Customer Phone Number:").split(" ")
    param=input("Enter the attribute names to modify(multiple possible)(LIKE: \"x\" \"y\"):").split(" ")
    vals=input("Assign the new value for the attribute to be equal to(respectively)(LIKE : a b):").split(" ")
    update("Customer",param,vals,["PHONE_NO"],cond_val)

def EditEmployeeDetails():
    """Edit an Employee's details"""
    cond_val=input("Enter the EID:").split(" ")
    param=input("Enter the attribute names to modify(multiple possible)(LIKE: \"x\" \"y\"):").split(" ")
    vals=input("Assign the new value for the attribute to be equal to(respectively)(LIKE : a b):").split(" ")
    update("Employee",param,vals,["EID"],cond_val)

def EditRestaurantDetails():
    """Edit a restaurant's details"""
    cond_val=input("Enter the REST_ID:").split(" ")
    param=input("Enter the attribute names to modify(multiple possible)(LIKE: \"x\" \"y\"):").split(" ")
    vals=input("Assign the new value for the attribute to be equal to(respectively)(LIKE : a b):").split(" ")
    update("Restaurant",param,vals,["REST_ID"],cond_val)

def EditDependantsDetails():
    """Edit a Dependant's details"""
    cond_val=input("Enter the values of EID and DEPENDANT NAME:").split(" ")
    param=input("Enter the attribute names to modify(multiple possible)(LIKE: \"x\" \"y\"):").split(" ")
    vals=input("Assign the new value for the attribute to be equal to(respectively)(LIKE : a b):").split(" ")
    update("Dependant",param,vals,["EID","DEPENDANT_NAME"],cond_val)

def DeleteCustomer():
    """Deletes record from Customer"""
    cond=input("The phone number of the customer is :").split()
    delete("Feedback",["CUSTOMER_PHONE"],cond)
    delete("Customer",["PHONE_NO"],cond)

def FireEmployee():
    """Deletes record from Employee"""
    cond=input("The Employee ID is :").split()
    delete("Dependent",["EID"],cond)
    delete("Employee",["EID"],cond)

def DeleteRestaurant():
    """"Function to Delete a particular record of table Restaurant"""
    cond=input("The Restaurant ID is:").split()
    delete("Item",["REST_ID"],cond)
    delete("Restaurant",["REST_ID"],cond)

def RemoveDependant():
    """Function to Delete a particular dependent"""
    cond=input("Enter the EID and dependent name respectively(spaced):").split()
    delete("Dependent",["Essn","Dep_Name"],cond)     ### check!

def DeleteItem():
    cond=input("Enter the REST_ID and ItemID respectively(spaced):").split()
    delete("Item",["REST_ID","ITEM_ID"],cond)     ### check!

def DeleteFeedback():
    cond=input("Enter the Customer Phone number and Rest_Name:").split()
    delete("Feedback",["CUSTOMER_PHONE","RESTAURANT_NAME"],cond)

# def CancelOrder():                     ### #####################
#     """This is the function to Cancel Order placed by the Customer"""


def ShowCustomers():
    """Shows customers"""
    show("Customer")

def ShowEmployees():
    """Shows employees"""
    show("Employee")

def ShowRestaurants():
    """Shows restaurants"""
    show("Restaurant")

def ShowFeedback():
    """Shows feedback"""
    show("Feedback")

def ShowDependants():
    """Shows Dependants"""
    show("Dependants")

def ShowDeliveries():
    """Shows deliveries"""
    show("Delivery")

def FavRest():
    cmd="""SELECT a.RESTAURANT_NAME, a.Total_Qty as MaxAvg FROM(SELECT AVG(s.RATINGS_OUT_OF_5) AS Total_Qty, s.RESTAURANT_NAME FROM Feedback s GROUP
    BY s.RESTAURANT_NAME) AS a Order by a.Total_Qty Desc Limit 1;"""
    try:
        cur.execute(cmd)
        for i in cur:
            print(i)
        print("This is the highest rated restaurant")
    except Exception as e:
        print("Exception,Unable to generate report")
        print(">>>",e)

def EffEmpl():
    cmd="select * from Employee where PHONE_NO = (select DELIVERY_PHONE from Delivery group by DELIVERY_PHONE order by count(*) desc LIMIT 1);"
    try:
        cur.execute(cmd)
        for i in cur:
            print(i)
        print("This is the most efficient employee")
    except Exception as e:
        print("Exception,Unable to generate report")
        print(">>>",e)


def OrderReceived(ID):                              ##########################
    # raise NotImplementedError       
    try:
        cmd= "UPDATE ORDER SET STAT = 'YES' WHERE ORDER_ID = "
        cmd+="\'"+str(ID)+"\'"
        cur.execute(cmd)

        cmd= "UPDATE PAYMENT SET STAT = 'YES' WHERE ORDER_ID = "
        cmd+="\'"+str(ID)+"\'"
        cur.execute(cmd)

        cmd= "UPDATE DELIVERY SET STAT = 'YES' WHERE ORDER_ID = "
        cmd+="\'"+str(ID)+"\'"
        cur.execute(cmd)
    
    except Exception as e:
        con.rollback()
        print("Failed to insert into database")
        print(">>>>>>>>>",e)

if __name__ == '__main__':
    flag=0
    X=None
    Y=None
    while(1):
        tmp = sp.call('clear',shell=True)
        # username = input("Username:")
        # pwd=input("Password:")
        username="pushkar"
        pwd="Hello@123"    
        try:
            con=pymysql.connect(host='localhost',user=username,password=pwd,db='online_food',cursorclass=pymysql.cursors.DictCursor)
            tmp=sp.call('clear',shell=True)
            if(con.open):
                print("Successfully Connected!")
            else:
                print("Failed to Connect")
            tmp=input("Press any key to continue:")            
            with con:
                cur = con.cursor()
                while (1):
                    print("What do you want to do?")
                    print("\t1) Add a Customer")
                    print("\t2) Hire Employee")
                    print("\t3) Add a Dependant")
                    print("\t4) Add a Restaurant")
                    print("\t5) Add a Feedback")
                    print("\t6) Call Customer care")
                    print("\t7) Place an Order")     # add a pay
                    print("\t8) Edit Customer Details")
                    print("\t9) Edit Employee Details")
                    print("\t10) Edit Restaurant Details")
                    print("\t11) Edit Dependants Details")
                    print("\t12) Delete Customer Details")
                    print("\t13) Fire Employee")
                    print("\t14) Delete Restaurant")
                    print("\t15) Remove a Dependant")
                    # print("\t15) Cancel an Order")
                    print("\t16) Show Customers")
                    print("\t17) Show Employees")
                    print("\t18) Show Payments due")
                    print("\t19) Show Orders due")
                    print("\t20) Show Restaurants")
                    print("\t21) Show Feedbacks")
                    print("\t22) Show Dependants")
                    print("\t23) Show Deliveries due")
                    print("\t24) Order Received! (change status)")
                    print("\t25) Add address for Customer")
                    print("\t26) Add email for Customer")
                    print("\t27) Add item to menu of a restaurant")
                    print("\t28) Delete item of menu of a restaurant")
                    print("\t29) Delete Feedback of a customer for restaurant")
                    print("\t30) Report the most efficient delivery Employee:")
                    print("\t31) Report the top rated restaurants(feedback based)")
                    print("\t32) Exit the application")
                    ch=input("\nEnter your choice number:")
                    try:
                        ch=int(ch)
                    except:
                        print("Enter an integer")
                    else:
                        if ch == 1:
                           AddCustomer() 
                        elif ch == 2:
                            HireEmployee()
                        elif ch == 3:
                            AddDependant()
                        elif ch == 4:
                            AddRestaurant()
                        elif ch == 5:
                            AddFeedback()
                        elif ch ==6:
                            AddCall()
                        elif ch == 7:
                            PlaceOrder()
                        elif ch == 8:
                            EditCustomerDetails()
                        elif ch == 9:
                            EditEmployeeDetails()
                        elif ch == 10:
                            EditRestaurantDetails()
                        elif ch == 11:
                            EditDependantsDetails()
                        elif ch == 12:
                            DeleteCustomer()
                        elif ch == 13:
                            FireEmployee()
                        elif ch == 14:
                            DeleteRestaurant()
                        elif ch == 15:
                            RemoveDependant()
                        # elif ch == 16:
                        #     CancelOrder()
                        elif ch == 16:
                            ShowCustomers()

                        elif ch == 17:
                            ShowEmployees()
                            
                        elif ch == 18:
                            ShowPayments()
                        
                        elif ch == 19:
                            ShowOrder()
                            
                        elif ch == 20:
                            ShowRestaurants()
                            
                        elif ch == 21:
                            ShowFeedback()

                        elif ch == 22:
                            ShowDependants()
                    
                        elif ch == 23:
                            ShowDeliveries()

                        elif ch == 24:
                            ID=input("Enter the order ID:")
                            OrderReceived(ID)

                        elif ch == 25:
                            AddAddress()

                        elif ch == 26:
                            AddEmail()

                        elif ch == 27:
                            AddItem()
                        
                        elif ch == 28:
                            DeleteItem()

                        elif ch == 29:
                            DeleteFeedback()

                        elif ch == 30:
                            EffEmpl()

                        elif ch == 31:
                            FavRest()

                        elif ch == 32:
                            flag=1
                            print("Thank you for using the application!")
                            break

                        else :
                            print("Invalid Choice Entered. Try again.")
        except:
            tmp = sp.call('clear',True)
            print("Connection Refused: Either username or password is incorrect or the user does not have access to this database.")
            tmp = input("Enter any key to continue:")
        else:
            if flag == 1:
                break

