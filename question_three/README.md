## 绝对居中

这里实现了三种不定高宽容器的绝对居中效果，它们分别是通过`table-cell`、`flex`、`transform`及其相关属性实现。

### table-cell 实现

[演示地址](https://jsfiddle.net/weijie/yr3x539r/4/)，代码存放在「./table_cell」目录中。

优点：兼容性良好，在多个`.container`同排的时候可以实现等高居中

缺点:`.container`的`display`属性被设置为了`table-cell`这意味着：

- `.container`的宽度无论怎么设置都不能超过其父元素的宽度

- 如果 `.container` 的父元素不是表格行，有的浏览器会静默的创建一个持有 `display: row` 属性的元素。

适用场景：需要等高居中布局的场景，不能直接作为遮罩层。

### flex 实现

[演示地址](https://jsfiddle.net/weijie/p53zdgL6/)，代码存放在「./flex」目录中。

优点：使用方便，天然支持各种居中，可融入现有布局。

缺点：兼容性欠佳，同时不方便「过来一点点」的细微调整。

适用场景：使用 flex 布局的项目，或者对浏览器兼容性不做要求的项目，不能直接作为遮罩层。

### transform 实现

[演示地址](https://jsfiddle.net/weijie/mr833a4t/)，代码存放在「./transform」目录中。

优点：可以直接作为遮罩层使用，容易与 transition 联合使用。

缺点: 兼容性一般，要求 .container 触发 BFC 特性。

适用场景：在现代浏览器下，作为遮罩层使用。