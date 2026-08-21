-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/HacktoolGuideView.lua

module("logic.extensions.hacktool.view.HacktoolGuideView", package.seeall)

local M = class("HacktoolGuideView", ViewComponent)

function M:buildUI()
	self._btnImg = self:getBtn("guide_hacktool_panel_224242849")
	self._btnText = self:getBtn("guide_hacktool_panel_-950571083")
	self._btnInteractive = self:getBtn("guide_hacktool_panel_-951676380")
	self._btnPPT = self:getBtn("guide_hacktool_panel_-1335916450")
	self._btnReturn = self:getBtn("0&title_view_-878360263")
	self._btnEnter = self:getBtn("guide_hacktool_panel_1021757795")
	self._btnVideo = self:getBtn("guide_hacktool_panel_311359700")
	self._txtId = self:getText("guide_hacktool_panel_1632153163")
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnImg:AddClickListener(self._onClickImg, self)
	self._btnText:AddClickListener(self._onClickText, self)
	self._btnInteractive:AddClickListener(self._onClickInteract, self)
	self._btnPPT:AddClickListener(self._onClickPPT, self)
	self._btnEnter:AddClickListener(self._onClickEnter, self)
	self._btnVideo:AddClickListener(self._onClickVideo, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnImg:RemoveClickListener()
	self._btnText:RemoveClickListener()
	self._btnInteractive:RemoveClickListener()
	self._btnPPT:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
	self._btnVideo:RemoveClickListener()
end

function M:_onClickReturn()
	self:back()
end

function M:_onClickClose()
	ViewMgr.instance:close(ViewName.ImageGuide)
end

function M:_onClickImg()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		2001
	})
end

function M:_onClickVideo()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		0,
		6,
		{
			"guide_battle_zhuici",
			"1",
			"异能 -【锥刺】：对目标造成相当于自身100%防御的真实伤害"
		}
	})
end

function M:_onClickText()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		1001
	})
end

function M:_onClickInteract()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		3001
	})
end

function M:_onClickPPT()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		4001
	})
end

function M:_onClickEnter()
	if string.nilorempty(self._txtId.text) then
		printError("请输入说明图ID")
	else
		ViewMgr.instance:open(ViewName.ImageGuide, {
			tonumber(self._txtId.text)
		})
	end
end

return M
