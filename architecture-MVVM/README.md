# notificationCenterを使ったMVVMの実現
(参考)https://peaks.cc/books/iOS_architecture  

## View
ViewController  
ユーザーのインプットを受け取り、ViewModelに値を受け渡す。  
ViewModelから状態を受け取り、Viewの状態を更新する  

## ViewModel
ViewModel  
ModelとViewの架け橋。  
Viewで表示するためのモデルというイメージ  
modelのビジネスロジックを使って、Viewで表示するためのデータの加工を行う。   

## Model
Model  
ビジネスロジック。  
アプリケーションに依存しない
