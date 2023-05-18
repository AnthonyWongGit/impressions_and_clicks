import pandas
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

df = pandas.read_csv('data/dataset1.csv')

# convert asset column into numerical values
d = {'Asset1': 1, 'Asset2': 2, 'Asset3': 3, 'Asset4': 4, 'Asset5': 5}
df['asset'] = df['asset'].map(d)

# separate features from target column
features = ['impressions', 'clicks', 'video_midpoint', 'video_complete_views', 'asset']

X = df[features]
y = df['conversions']

# split into train/test sets
train_X, test_X, train_y, test_y = train_test_split(X, y, test_size=0.2, random_state=42)

# create decision tree and fit training set
dtree = DecisionTreeClassifier()
dtree = dtree.fit(train_X, train_y)

# create a prediction on test set
predictions = dtree.predict(test_X)

# compute accuracy
accuracy_score = accuracy_score(test_y, predictions)

print(f"Model accuracy is {accuracy_score}")