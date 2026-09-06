-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/HeroSkillSelectView.lua

module("logic.extensions.formation.view.HeroSkillSelectView", package.seeall)

local HeroSkillSelectView = class("HeroSkillSelectView", TableViewComponent)

function HeroSkillSelectView:_getPath()
	return {
		cellPath = "Cell",
		viewPath = "ScrollView"
	}
end

function HeroSkillSelectView:ctor()
	HeroSkillSelectView.super.ctor(self)
end

function HeroSkillSelectView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function HeroSkillSelectView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function HeroSkillSelectView:buildUI()
	HeroSkillSelectView.super.buildUI(self)

	self._closeButton = self:getBtn("Close")
end

function HeroSkillSelectView:destroyUI()
	return
end

function HeroSkillSelectView:onEnter()
	HeroSkillSelectView.super.onEnter(self)

	self._curViewDatas = self._viewPresentor._openParam[1] or {}
	self._func = self._viewPresentor._openParam[2]
	self._tar = self._viewPresentor._openParam[3]
	self._currHeroSkill = self._viewPresentor._openParam[4]

	self._tableview:ReloadData()
end

function HeroSkillSelectView:onEnterFinished()
	return
end

function HeroSkillSelectView:onExit()
	HeroSkillSelectView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil
	self._currHeroSkill = nil
end

function HeroSkillSelectView:onExitFinished()
	return
end

function HeroSkillSelectView:_cellSize()
	return 120, 100
end

function HeroSkillSelectView:_updateCell(view, cell, data)
	local img = goutil.findChild(cell, "ImgMaster")
	local txt = goutil.findChildTextComponent(cell, "TxtSkillName")
	local sel = goutil.findChild(cell, "ImgC_Selected")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "ImgC_Bg")
	local longPress = goutil.findChild(cell, "ImgC_Bg"):GetComponent("UILongPressed")

	if not self._currHeroSkill then
		local curId = FormationController.instance:GetHeroSkillId()
		local cfg = BattleConfig.instance:getSkillCo(checknumber(data))

		sel:SetActive(curId == data)

		txt.text = cfg.name

		BagPetsFacade.setHeadIconByRaceId(img, math.fmod(data, 100000))
		btn:AddClickListener(function()
			self:_onSelectCell(data)
		end, self)
		longPress:AddListener(function(tar, isUp)
			self:_onLongPress(isUp, checknumber(data), cell)
		end, self)
	end
end

function HeroSkillSelectView:_onSelectCell(data)
	if not self._longPressing then
		if self._func then
			self._func(self._tar, data)
		end

		self:close()
	end
end

function HeroSkillSelectView:_clearTableview(cell)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "ImgC_Bg")
	local longPress = goutil.findChild(cell, "ImgC_Bg"):GetComponent("UILongPressed")

	btn:RemoveClickListener()
	longPress:RemoveListener()
end

function HeroSkillSelectView:_onLongPress(isUp, skillId, go)
	if not isUp then
		CommonTipsMgr.instance:openMaterialTips(go, MatType.Skill, skillId)

		self._longPressing = true
	else
		CommonTipsMgr.instance:closeAllTips()
		coroutine.start(function()
			coroutine.wait(0.1)

			self._longPressing = false
		end)
	end
end

function HeroSkillSelectView:_onClickClose()
	self:close()
end

return HeroSkillSelectView
