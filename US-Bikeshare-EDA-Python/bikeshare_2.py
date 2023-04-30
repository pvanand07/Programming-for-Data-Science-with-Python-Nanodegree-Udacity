import time
import pandas as pd
import numpy as np

CITY_DATA = { 'chicago': 'chicago.csv',
              'new york city': 'new_york_city.csv',
              'washington': 'washington.csv' }

def get_filters():
    '''
    Asks user to specify a city, month, and day to analyze.

    Returns:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    '''
    # Print a welcome message to the user
    print("Hello! Let's explore some US bikeshare data!")

    # Get a list of available cities from the CITY_DATA dictionary
    cities = list(CITY_DATA.keys())

    # Ask the user to input a city name to filter by
    city = input(f"Enter city name to filter by {cities}").lower()

    # Keep asking for city input until a valid city name is entered
    while city not in cities:
        city = input(f"Try again, Enter city name to filter by {cities}").lower()

    # Define a list of available months to filter by
    months = ['all', 'january', 'february', 'march', 'april', 'may', 'june']

    # Ask the user to input a month name to filter by
    month = input(f"Enter month name to filter by {months}").lower()

    # Keep asking for month input until a valid month name is entered
    while month not in months:
        month = input(f"Enter month name to filter by {months}").lower()

    # Define a list of available days of the week to filter by
    days = ['all', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']

    # Ask the user to input a day of the week to filter by
    day = input(f"Enter day name to filter by {days}").lower()

    # Keep asking for day input until a valid day name is entered
    while day not in days:
        day = input(f"Try again, Enter day name to filter by {days}").lower()

    print('-'*45)
    return city, month, day

def load_data(city, month, day):
    # provide postion arguments in the function definition to load data for the specified city, month and day

    '''
    Loads data for the specified city and filters by month and day if applicable.

    Args:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter

    Returns:
        df - Pandas DataFrame containing city data filtered by month and day
    
    '''
    # Load data from the specified city
    df = pd.read_csv(CITY_DATA[city])

    # Convert the "Start Time" column to datetime format
    df['Start Time'] = pd.to_datetime(df['Start Time'])

    # Extract the month, day of week, and hour from the "Start Time" column
    df['month'] = df['Start Time'].dt.month
    df['day_of_week'] = df['Start Time'].dt.day_name()
    df['hour'] = df['Start Time'].dt.hour

    # Filter the data by the specified month
    if month != 'all':
        months = ['january', 'february', 'march', 'april', 'may', 'june']
        df = df[df['month'] == (months.index(month)+1)]

    # Filter the data by the specified day of week
    if day != 'all':
        df = df[df['day_of_week'] == day.title()]

    # Display the first five rows of the filtered data and return it

    display(df.head().T)
    print('-' * 40)
    return df


def time_stats(df):
    """Displays statistics on the most frequent times of travel."""

    print('\nCalculating The Most Frequent Times of Travel...\n')
    start_time = time.time()

    # display the most common month


    # display the most common day of week


    # display the most common start hour


    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def station_stats(df):
    """Displays statistics on the most popular stations and trip."""

    print('\nCalculating The Most Popular Stations and Trip...\n')
    start_time = time.time()

    # display most commonly used start station


    # display most commonly used end station


    # display most frequent combination of start station and end station trip


    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def trip_duration_stats(df):
    """Displays statistics on the total and average trip duration."""

    print('\nCalculating Trip Duration...\n')
    start_time = time.time()

    # display total travel time


    # display mean travel time


    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def user_stats(df):
    """Displays statistics on bikeshare users."""

    print('\nCalculating User Stats...\n')
    start_time = time.time()

    # Display counts of user types


    # Display counts of gender


    # Display earliest, most recent, and most common year of birth


    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def main():
    while True:
        city, month, day = get_filters()
        df = load_data(city, month, day)

        time_stats(df)
        station_stats(df)
        trip_duration_stats(df)
        user_stats(df)

        restart = input('\nWould you like to restart? Enter yes or no.\n')
        if restart.lower() != 'yes':
            break


if __name__ == "__main__":
	main()
