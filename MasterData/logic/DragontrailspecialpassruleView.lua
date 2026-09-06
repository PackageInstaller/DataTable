-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrailspecialpassruleView.lua

module("logic.extensions.dragontrial.view.DragontrailspecialpassruleView", package.seeall)

local DragontrailspecialpassruleView = class("DragontrailspecialpassruleView", ViewComponent)
local posList = {
	{
		z = 0,
		x = 168,
		y = -202.3
	},
	{
		z = 0,
		x = 234.7,
		y = 241.6
	},
	{
		z = 0,
		x = 234.7,
		y = 182.3
	},
	{
		z = 0,
		x = 168,
		y = -202.3
	}
}

function DragontrailspecialpassruleView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._togSelect = self:getToggle("main/togSelect")
	self._txt1 = self:getTxt("main/leftTip/txt1")
	self._txt2 = self:getTxt("main/rightTip/txt2")
	self._txt3 = self:getTxt("main/txt3")
	self._btnNode1 = self:getGo("main/btn1/node")
	self._btnNode2 = self:getGo("main/btn2/node")
	self._txtName1 = self:getGo("main/btn1/name/txtName"):GetComponent(goutil.Type_UIText)
	self._txtName2 = self:getGo("main/btn2/name/txtName"):GetComponent(goutil.Type_UIText)
	self._btn1 = self:getBtn("main/btn1")
	self._btn2 = self:getBtn("main/btn2")
	self._imgRule = self:getGo("main/imgRule")
	self._leftTip = self:getGo("main/leftTip")
	self._rightTip = self:getGo("main/rightTip")
end

function DragontrailspecialpassruleView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btn1:AddClickListener(self._onClickBtn1, self)
	self._btn2:AddClickListener(self._onClickBtn2, self)
end

function DragontrailspecialpassruleView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btn1:RemoveClickListener()
	self._btn2:RemoveClickListener()
end

function DragontrailspecialpassruleView:onEnter()
	local params = self:getOpenParam()

	self._planId = params[1]
	self._stageId = params[2]
	self._togSelect.isOn = GameUtil.getUserDayData(MissionConst.MissionDragonTrial .. self._planId .. "@" .. self._stageId)

	if posList[self._planId] then
		if not posList[self._planId] then
			local pos = {
				z = 0,
				x = 0,
				y = 0
			}

			Framework.TransformUtil.SetLocalPos(self._rightTip.transform, pos.x, pos.y, pos.z)

			self._cfg = DragontrialConfig.instance:getStageById(self._planId, self._stageId)

			if self._cfg then
				uGuiUtil.setSpriteToImage(self._imgRule, uGuiUtil.SpriteType.BigBg, GameUrl.getCopyChapterBgUrl(self._cfg.popupPic))
			end
		end
	end
end

function DragontrailspecialpassruleView:onExit()
	self:_saveToggleState()

	local component = Framework.ImageBigBG.Get(self._imgRule)

	component:ClearImage()
end

function DragontrailspecialpassruleView:_onClickClose()
	self:close()
end

function DragontrailspecialpassruleView:_saveToggleState()
	GameUtil.saveUserDayData(MissionConst.MissionDragonTrial .. self._planId .. "@" .. self._stageId, self._togSelect.isOn)
end

function DragontrailspecialpassruleView:_onClickBtn1()
	if self._cfg then
		MaterialMgr.openGetSource(MatType.PetPiece, self._cfg.FirstRecommendId, function()
			UIStateManager.instance:clear()
		end)
	end
end

function DragontrailspecialpassruleView:_onClickBtn2()
	if self._cfg then
		MaterialMgr.openGetSource(MatType.PetPiece, self._cfg.SecondRecommendId, function()
			UIStateManager.instance:clear()
		end)
	end
end

return DragontrailspecialpassruleView
