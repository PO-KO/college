#include <iostream>
using namespace std;

class Account
{
    static int count;

protected:
    int balance;

public:
    Account() : balance(0)
    {
        count++;
    }

    Account(int s) : balance(s)
    {
        count++;
    }
    // void deposit()
    // {
    //     int depMon;
    //     cout << "Enter the amount of money you want to deposit : ";
    //     cin >> depMon;
    //     balance += depMon;
    // }

    // void withdraw()
    // {
    //     int wdMon;
    //     cout << "Enter the amount of money you want to withdraw : ";
    //     cin >> wdMon;
    //     if (balance >= wdMon)
    //     {
    //         balance -= wdMon;
    //     }else {
    //         cout << "You dont have money to withdraw\n";
    //     };
    // }

    virtual void deposit()
    {
        cout << "deposit";
    }
    virtual void withdraw()
    {
        cout << "withdraw";
    }

    void displayAccount()
    {
        cout << "Your Account is : \n- Balance : " << balance << " $ \n";
    }

    static int getCount()
    {
        return count;
    }
};

int Account::count = 0;

class PersonalAccount : public Account
{
public:
    PersonalAccount(int b)
    {
        balance = b;
    }
    void deposit()
    {
        int depMon;
        cout << "Enter the amount of money you want to deposit : ";
        cin >> depMon;
        cout << depMon;
        depMon = depMon - (3 * depMon / 100);
        cout << depMon;
        balance += depMon;
    }
    void withdraw()
    {
        int wdMon;
        cout << "Enter the amount of money you want to withdraw : ";
        cin >> wdMon;
        wdMon = wdMon - (2 * wdMon / 100);
        if (balance >= wdMon)
        {
            balance -= wdMon;
        }
        else
        {
            cout << "You dont have money to withdraw\n";
        };
    }

};

class ProfessionalAccount : public Account
{
public:
    ProfessionalAccount(int b)
    {
        balance = b;
    }
    void deposit()
    {
        int depMon;
        cout << "Enter the amount of money you want to deposit : ";
        cin >> depMon;
        depMon = depMon - (6 * depMon / 100);
        balance += depMon;
    }
    void withdraw()
    {
        int wdMon;
        cout << "Enter the amount of money you want to withdraw : ";
        cin >> wdMon;
        wdMon = wdMon - (5 * wdMon / 100);
        if (balance >= wdMon)
        {
            balance -= wdMon;
        }
        else
        {
            cout << "You dont have money to withdraw\n";
        };
    }
};

void display(Account* a)
{

    a->deposit();
}

int main()
{
    // Account a1(1000);
    // display(a1);

    PersonalAccount pera(514);
    ProfessionalAccount proa(514); 

    // proa.deposit();
    // proa.displayAccount();

    // proa.withdraw();
    // proa.displayAccount();

    // display(&pera);
    // pera.displayAccount();

    display(&proa);
    proa.displayAccount();

    // a1.deposit();
    // a1.displayAccount();
    cout << "\n==========================\n";
    cout << Account::getCount() << " Accounts";
    return 0;
}