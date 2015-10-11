-----------------------------------------------------------------------------------------
--
-- main.lua
-- 此範例用以介紹Container這個功能的使用方式與時機
-- Author: Zack Lin
-- Time:2015/10/11
-----------------------------------------------------------------------------------------
--[[  Container練習

]]
--=======================================================================================
--引入各種函式庫
--=======================================================================================
display.setStatusBar( display.HiddenStatusBar )
-- 載入widget Library
local widget = require ("widget")
--=======================================================================================
--宣告各種變數

--=======================================================================================
--宣告各種全域變數
_SCREEN = {
	WIDTH = display.contentWidth,
	HEIGHT = display.contentHeight
}
_SCREEN.CENTER = {
	X = display.contentCenterX,
	Y = display.contentCenterY
}
--=======================================================================================
--宣告各種區域變數
local container
local t_imgFile = {"girl1.jpg" , "girl2.jpg" , "girl3.jpg" , "girl4.jpg"}
local index_img = 1
local t_imgs = {}

--宣告各種區域函式
local initial
local goBottom
local goBack
--=======================================================================================
--宣告與定義main()函式
--=======================================================================================
local main = function (  )
	initial()
end
--=======================================================================================
--定義其他函式
--=======================================================================================
--初始化函式，一般用於建立元件，設定初始值，部署元件等工作...
initial = function (group)
	--建立容器
	container = display.newContainer( _SCREEN.WIDTH, _SCREEN.HEIGHT /2 )
	container.x = _SCREEN.CENTER.X
	container.y = _SCREEN.HEIGHT / 2
	container.anchorChildren = false --將子元件隨錨點變更移動的功能關閉，以達成Mask效果
	container.anchorY = 0

	--建立容器內的子元件
	for i=1,#t_imgFile do
		local img = display.newImageRect(container, t_imgFile[i], _SCREEN.WIDTH, _SCREEN.HEIGHT )
		table.insert( t_imgs, i, img )
		if (i ~= 1) then
			img.isVisible = false
		end
	end
	
	goBottom()	
end

goBottom = function (  )
	transition.to( container, {time=1500 , anchorY = 1 , onComplete=function ( )
		goBack()
	end} )
end

goBack = function (  )
	transition.to( container, {time=1500 , anchorY = 0 , onComplete=function ( )
		t_imgs[index_img].isVisible = false
		index_img = index_img + 1
		if (index_img > #t_imgs) then
			index_img = 1
		end
		t_imgs[index_img].isVisible = true
		goBottom()
	end} )
end
--=======================================================================================
--呼叫主函式
--=======================================================================================
-- 先完成所有的宣告以及賦值，最後才執行main方法啟動工作
main()

