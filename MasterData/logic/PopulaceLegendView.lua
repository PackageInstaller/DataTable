-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/PopulaceLegendView.lua

module("logic.extensions.activitypopup.view.PopulaceLegendView", package.seeall)

local PopulaceLegendView = class("PopulaceLegendView", ActivityPopupBase)

function PopulaceLegendView:ctor()
	PopulaceLegendView.super.ctor(self)
end

function PopulaceLegendView:buildUI()
	PopulaceLegendView.super.buildUI(self)

	self._itemBtn = {}
	self._imgRed = {}

	for i = 1, 6 do
		self._itemBtn[i] = self:getBtn(string.format("content/item%d/btnClick", i))
		self._imgRed[i] = self:getGo(string.format("content/item%d/btnClick/imgRed", i))
	end

	self._recordBg = self:getGo("icon"):GetComponent("TestRecordPos")
	self._recordPos = self:getGo("content"):GetComponent("TestRecordPos")
	self._btnInfo = self:getBtn("icon/btnInfo")
end

function PopulaceLegendView:bindEvents()
	PopulaceLegendView.super.bindEvents(self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
end

function PopulaceLegendView:unbindEvents()
	PopulaceLegendView.super.unbindEvents(self)
	self._btnInfo:RemoveClickListener()
end

function PopulaceLegendView:onEnter()
	PopulaceLegendView.super.onEnter(self)

	local cfg = self:getActivityPopupCfg()

	if not cfg then
		return
	end

	self._jumpCfgs = ActivityPopupConfig.instance:getActivityPopupJumpCfgs(cfg.jumpId)

	if not self._jumpCfgs or #self._jumpCfgs == 0 then
		return
	end

	local count = #self._jumpCfgs

	self._recordBg:LoadPlan(count - 4)
	self._recordPos:LoadPlan(count - 4)

	for i = 1, count do
		local jumpTo = self._jumpCfgs[i].jumpTo
		local jumpList = string.split(jumpTo, "#")
		local funcId = jumpList and checknumber(jumpList[2]) or nil

		self._itemBtn[i]:AddClickListener(function()
			if funcId == 131 and SevenDaysModel.instance:GetFunctionActivityId() <= 0 then
				FloatWordMgr.instance:show("活动未开始！")

				return
			end

			UIStateManager.instance:clear()
			GotoMgr.gotoByString(jumpTo)
		end)
		goutil.setActive(self._imgRed[i], (funcId > 0 or nil) and PopulaceLegendModel.instance:isActiveRedPointByFuncId(funcId))
		uGuiUtil.setSpriteToImage(self._itemBtn[i].gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/populacelegend/%s.png", self._jumpCfgs[i].icon))
	end
end

function PopulaceLegendView:onExit()
	PopulaceLegendView.super.onExit(self)

	if self._jumpCfgs then
		local count = #self._jumpCfgs

		for i = 1, count do
			self._itemBtn[i]:RemoveClickListener()

			local img = Framework.ImageBigBG.Get(self._itemBtn[i].gameObject)

			if img then
				img:ClearImage()
			end
		end
	end
end

function PopulaceLegendView:_onClickInfo()
	UIStateManager.instance:open(ViewName.RulesView, "populacelegend")
end

return PopulaceLegendView
