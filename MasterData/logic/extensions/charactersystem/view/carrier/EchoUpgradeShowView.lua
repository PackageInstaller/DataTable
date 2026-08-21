-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/EchoUpgradeShowView.lua

module("logic.extensions.charactersystem.view.carrier.EchoUpgradeShowView", package.seeall)

local M = class("EchoUpgradeShowView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._showCardView = Astral.LuaComponentContainer.Add(self:getGo("echo_show_card_-997813653"), HandbookEchoShowCardCell)

	self._showCardView:setAddBtnVisible(false)

	self._btnClose = self:getBtn("echo_upgrade_show_panel_754494956")
	self._txtHint1 = self:getText("echo_upgrade_show_panel_-371015201")
	self._txtHint2 = self:getText("echo_upgrade_show_panel_-1374391358")
	self._breakPointView1 = Astral.LuaComponentContainer.Add(self:getGo("1&break_point_-2114175626"), EchoItemBreakPointView)
	self._breakPointView2 = Astral.LuaComponentContainer.Add(self:getGo("2&break_point_-2114175626"), EchoItemBreakPointView)
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._upgradePointEffLst = {}
	self._upgradePointEffLst[2] = {
		self:getGo("echo_upgrade_show_panel_-11248409"),
		self:getGo("echo_upgrade_show_panel_-1445512370")
	}
	self._upgradePointEffLst[3] = {
		self:getGo("echo_upgrade_show_panel_-602828052"),
		self:getGo("echo_upgrade_show_panel_524328764")
	}
	self._upgradePointEffLst[4] = {
		self:getGo("echo_upgrade_show_panel_-641901113"),
		self:getGo("echo_upgrade_show_panel_1924367746")
	}
	self._upgradePointEffLst[5] = {
		self:getGo("echo_upgrade_show_panel_-61975131"),
		self:getGo("echo_upgrade_show_panel_-669950211")
	}
	self._upgradePointEffLst[6] = {
		self:getGo("echo_upgrade_show_panel_1320182952"),
		self:getGo("echo_upgrade_show_panel_1367412958")
	}
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	GlobalDispatcher:addEventListener(EventType.ON_BLUR_BG_CAPTURE_FINISH, self._handleBlurBgCaptureFinish, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.ON_BLUR_BG_CAPTURE_FINISH, self._handleBlurBgCaptureFinish, self)
end

function M:onEnter()
	local info = self:getFirstParam()

	self._echoItemId = info.echoItemId
	self._echoMaxLv = EchoItemConfig.instance:getMaxLevel(self._echoItemId)
	self._curLevel = info.curLevel

	self:refreshView(self._curLevel - 1, self._curLevel)
end

function M:onExit()
	self._showCardView:onExit()
end

function M:_handleBlurBgCaptureFinish(e, viewName)
	self._showCardView:onEnter()
	self._showCardView:refreshView(self._echoItemId)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:_onClickClose()
	self:close()
end

function M:refreshView(preLv, curLv)
	local colorAttr = false

	self._breakPointView1:setEchoItemLevel(preLv, self._echoMaxLv)
	self._breakPointView2:setEchoItemLevel(curLv, self._echoMaxLv)

	local preDesc, curDesc = EchoItemConfig.instance:getUpgradeDesc(self._echoItemId, preLv, curLv, colorAttr)

	self._txtHint1.text = preDesc
	self._txtHint2.text = curDesc

	for lv, goLst in pairs(self._upgradePointEffLst) do
		local show = lv == curLv

		for _, go in ipairs(goLst) do
			goutil.setActive(go, show)
		end
	end
end

return M
