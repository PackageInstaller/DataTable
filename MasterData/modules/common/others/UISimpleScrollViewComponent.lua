-- chunkname: @modules/common/others/UISimpleScrollViewComponent.lua

module("modules.common.others.UISimpleScrollViewComponent", package.seeall)

local UISimpleScrollViewComponent = class("UISimpleScrollViewComponent", UserDataDispose)

function UISimpleScrollViewComponent:ctor()
	self:__onInit()

	self._sign_index = 0
end

function UISimpleScrollViewComponent:registScrollView(obj_root, scroll_param)
	self._scroll_view = self._scroll_view or {}

	local scroll = UISimpleScrollViewItem.New(self.parentClass, obj_root, scroll_param)

	scroll:__onInit()
	scroll:startLogic(obj_root, scroll_param)

	self._sign_index = self._sign_index + 1
	scroll.sign_index = self._sign_index

	table.insert(self._scroll_view, scroll)

	return scroll
end

function UISimpleScrollViewComponent:registSimpleScrollView(obj_root, scrollDir, lineCount)
	local scroll = self:registScrollView(obj_root)

	scroll:useDefaultParam(scrollDir, lineCount)

	return scroll
end

function UISimpleScrollViewComponent:releaseSelf()
	if self._scroll_view then
		for i, v in ipairs(self._scroll_view) do
			if v.releaseSelf then
				v:releaseSelf()
			end

			v:__onDispose()
		end
	end

	self._scroll_view = nil

	self:__onDispose()
end

return UISimpleScrollViewComponent
