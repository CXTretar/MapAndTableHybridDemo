## MapAndTableHybridDemo
### MapView和TableView混合界面,两者都有滚动手势,这里提供了两种处理方式.
#### 方式一 MapTableSeparateController
点击TableView头部空白区域,列表下滑隐藏,MapView才开始响应手势操作
#### 方式二 MapTableMergeController
TableView头部空白区域由MapView响应手势操作,TableViewCell区域由TableView响应手势操作.
### 两种方式均实现了导航栏随TableView滚动改变透明度的效果.


