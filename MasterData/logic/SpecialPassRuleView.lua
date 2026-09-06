-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/SpecialPassRuleView.lua

module("logic.extensions.mission.view.SpecialPassRuleView", package.seeall)

local SpecialPassRuleView = class("SpecialPassRuleView", ViewComponent)
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

function SpecialPassRuleView:buildUI()
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

function SpecialPassRuleView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btn1:AddClickListener(self._onClickBtn1, self)
	self._btn2:AddClickListener(self._onClickBtn2, self)
end

function SpecialPassRuleView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btn1:RemoveClickListener()
	self._btn2:RemoveClickListener()
end

function SpecialPassRuleView:onEnter()
	self._chapterId = self:getFirstParam()
	self._togSelect.isOn = GameUtil.getUserDayData(MissionConst.MissionMaterial .. self._chapterId)

	if posList[self._chapterId] then
		if not posList[self._chapterId] then
			local pos = {
				z = 0,
				x = 0,
				y = 0
			}

			Framework.TransformUtil.SetLocalPos(self._rightTip.transform, pos.x, pos.y, pos.z)

			self._cfg = MaterialChallengeConfig.instance:getChapter(self._chapterId)

			if self._cfg then
				self:_setTxts(self._cfg)
				self:_setBtns(self._cfg)
				uGuiUtil.setSpriteToImage(self._imgRule, uGuiUtil.SpriteType.BigBg, GameUrl.getCopyChapterBgUrl(self._cfg.popupPic))
			end
		end
	end
end

function SpecialPassRuleView:onExit()
	self:_saveToggleState()

	local component = Framework.ImageBigBG.Get(self._imgRule)

	component:ClearImage()
end

function SpecialPassRuleView:_onClickClose()
	self:close()
end

function SpecialPassRuleView:_saveToggleState()
	GameUtil.saveUserDayData(MissionConst.MissionMaterial .. self._chapterId, self._togSelect.isOn)
end

function SpecialPassRuleView:_setTxts(cfg)
	goutil.setActive(self._leftTip, not string.nilorempty(cfg.roundDes))

	self._txt1.text = cfg.roundDes

	goutil.setActive(self.rightTip, not string.nilorempty(cfg.FirstDes))

	self._txt2.text = cfg.FirstDes
	self._txt3.text = cfg.SecondDes
end

function SpecialPassRuleView:_setBtns(cfg)
	local cfgStr1 = MaterialMgr.createSerName(MatType.Pet, cfg.FirstRecommendId, 0, 1)
	local proxy1 = MaterialMgr.setCellByCfg(cfgStr1, self._btnNode1)
	local cfg1 = CharacterConfig.instance:getPetCo(cfg.FirstRecommendId)

	if cfg1 then
		self._txtName1.text = cfg1.name
	end

	local cfgStr2 = MaterialMgr.createSerName(MatType.Pet, cfg.SecondRecommendId, 0, 1)
	local proxy2 = MaterialMgr.setCellByCfg(cfgStr2, self._btnNode2)
	local cfg2 = CharacterConfig.instance:getPetCo(cfg.SecondRecommendId)

	if cfg2 then
		self._txtName2.text = cfg2.name
	end
end

function SpecialPassRuleView:_onClickBtn1()
	if self._cfg then
		MaterialMgr.openGetSource(MatType.PetPiece, self._cfg.FirstRecommendId, function()
			UIStateManager.instance:clear()
		end)
	end
end

function SpecialPassRuleView:_onClickBtn2()
	if self._cfg then
		MaterialMgr.openGetSource(MatType.PetPiece, self._cfg.SecondRecommendId, function()
			UIStateManager.instance:clear()
		end)
	end
end

return SpecialPassRuleView
