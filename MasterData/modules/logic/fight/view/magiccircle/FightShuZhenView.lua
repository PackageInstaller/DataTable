-- chunkname: @modules/logic/fight/view/magiccircle/FightShuZhenView.lua

module("modules.logic.fight.view.magiccircle.FightShuZhenView", package.seeall)

local FightShuZhenView = class("FightShuZhenView", BaseView)

function FightShuZhenView:onInitView()
	self._topLeftRoot = gohelper.findChild(self.viewGO, "root/topLeftContent")
	self._obj = gohelper.findChild(self.viewGO, "root/topLeftContent/#go_shuzhentips")
	self._detail = gohelper.findChild(self.viewGO, "root/#go_shuzhendetails")
	gohelper.onceAddComponent(self._detail, typeof(UnityEngine.Animator)).enabled = true
	self._detailHeightObj = gohelper.findChild(self.viewGO, "root/#go_shuzhendetails/details")
	self._detailTitle = gohelper.findChildText(self.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_title")
	self._detailRound = gohelper.findChildText(self.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_title/#txt_round")
	self._detailText = gohelper.findChildText(self.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_details")
	self._detailClick = gohelper.getClickWithDefaultAudio(gohelper.findChild(self._detail, "#btn_shuzhendetailclick"))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightShuZhenView:addEvents()
	self._detailClick:AddClickListener(self._onDetailClick, self)
	self.addEventCb(self, FightController.instance, FightEvent.AddMagicCircile, self._onAddMagicCircile, self)
	self.addEventCb(self, FightController.instance, FightEvent.DeleteMagicCircile, self._onDeleteMagicCircile, self)
	self.addEventCb(self, FightController.instance, FightEvent.UpdateMagicCircile, self._onUpdateMagicCircile, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClickMagicCircleText, self.OnClickMagicCircleText, self)
end

function FightShuZhenView:removeEvents()
	self._detailClick:RemoveClickListener()
end

function FightShuZhenView:_editableInitView()
	self:hideObj()
	gohelper.setActive(self._detail, false)
	SkillHelper.addHyperLinkClick(self._detailText, self.onClickShuZhenHyperDesc, self)

	self.detailRectTr = self._detail:GetComponent(gohelper.Type_RectTransform)
	self.viewGoRectTr = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.scrollRectTr = gohelper.findChildComponent(self.viewGO, "root/#go_shuzhendetails/details/#scroll_details", gohelper.Type_RectTransform)
	self.topLeftRootTr = self._topLeftRoot.transform
	self.detailTr = self._detail.transform

	for _, name in pairs(FightEnum.MagicCircleUIType2Name) do
		gohelper.setActive(gohelper.findChild(self._obj, "layout/" .. name), false)
	end
end

FightShuZhenView.TipIntervalX = 10

function FightShuZhenView:onClickShuZhenHyperDesc(effectId, clickPosition)
	local width = recthelper.getWidth(self.viewGoRectTr)
	local halfW = width / 2
	local anchorX = recthelper.getAnchorX(self.detailRectTr)
	local scrollWidth = recthelper.getWidth(self.scrollRectTr)
	local tipAnchorX = halfW - anchorX - scrollWidth - FightShuZhenView.TipIntervalX

	self.commonBuffTipAnchorPos = self.commonBuffTipAnchorPos or Vector2()

	self.commonBuffTipAnchorPos:Set(-tipAnchorX, 312.24)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(effectId, self.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Left)
end

function FightShuZhenView:OnClickMagicCircleText(preferredHeight, position)
	local pos = recthelper.rectToRelativeAnchorPos(position, self.topLeftRootTr)
	local y = pos.y - preferredHeight + recthelper.getAnchorY(self.topLeftRootTr)

	recthelper.setAnchorY(self.detailTr, y)

	local magicMo = FightModel.instance:getMagicCircleInfo()

	if magicMo then
		::label_6_0::

		local var_6_0 = magicMo.magicCircleId

		if magicMo.magicCircleId then
			local magicConfig = lua_magic_circle.configDict[magicMo.magicCircleId]

			if magicMo and magicConfig then
				gohelper.setActive(self._detail, true)

				local round = magicMo.round == -1 and "∞" or magicMo.round

				self._detailTitle.text = magicConfig.name
				self._detailRound.text = formatLuaLang("x_round", round)
				self._detailText.text = SkillHelper.buildDesc(magicConfig.desc)
			end
		end
	end
end

function FightShuZhenView:_onDetailClick()
	gohelper.setActive(self._detail, false)
end

function FightShuZhenView:addMagic()
	self:clearFlow()

	self.flow = FlowSequence.New()

	local magicItem = self.magicItem

	self.magicItem = nil

	self.flow:addWork(FightMagicCircleRemoveWork.New(magicItem))
	self.flow:addWork(FunctionWork.New(self.createMagicItem, self))
	self.flow:start()
end

function FightShuZhenView:removeMagic()
	self:clearFlow()

	self.flow = FlowSequence.New()

	local magicItem = self.magicItem

	self.magicItem = nil

	self.flow:addWork(FightMagicCircleRemoveWork.New(magicItem))
	self.flow:registerDoneListener(self.hideObj, self)
	self.flow:start()
end

FightShuZhenView.UiType2Class = {
	[FightEnum.MagicCircleUIType.Normal] = FightMagicCircleNormal,
	[FightEnum.MagicCircleUIType.Electric] = FightMagicCircleElectric,
	[FightEnum.MagicCircleUIType.LSJ] = FightMagicCircleLSJ
}

function FightShuZhenView:createMagicItem()
	local magicMo = FightModel.instance:getMagicCircleInfo()

	if not magicMo then
		return
	end

	if not magicMo.magicCircleId then
		return
	end

	local magicConfig = lua_magic_circle.configDict[magicMo.magicCircleId]

	if not magicConfig then
		return
	end

	self:showObj()

	local uiType = magicConfig.uiType
	local class = self.UiType2Class[uiType]

	class = class or FightMagicCircleNormal
	self.magicItem = class.New()

	local go = gohelper.findChild(self._obj, "layout/" .. FightEnum.MagicCircleUIType2Name[uiType])

	self.magicItem:init(go)
	self.magicItem:onCreateMagic(magicMo, magicConfig)
end

function FightShuZhenView:onOpen()
	self:addMagic()
end

function FightShuZhenView:_onAddMagicCircile(magicId, fromId)
	self:addMagic()
end

function FightShuZhenView:_onDeleteMagicCircile(magicId, fromId)
	self:removeMagic()
end

function FightShuZhenView:_onUpdateMagicCircile(magicId, fromId)
	local magicMo = FightModel.instance:getMagicCircleInfo()

	if not magicMo then
		return self:removeMagic()
	end

	if not magicMo.magicCircleId then
		return self:removeMagic()
	end

	local magicConfig = lua_magic_circle.configDict[magicMo.magicCircleId]

	if not magicConfig then
		return self:removeMagic()
	end

	local uiType = magicConfig.uiType

	if self.magicItem then
		local preUiType = self.magicItem:getUIType()

		if uiType == self.magicItem then
			self.magicItem:onUpdateMagic(magicMo, magicConfig, fromId)
		else
			self:addMagic()
		end
	end
end

function FightShuZhenView:hideObj()
	gohelper.setActive(self._obj, false)
end

function FightShuZhenView:showObj()
	gohelper.setActive(self._obj, true)
end

function FightShuZhenView:clearFlow()
	if self.flow then
		self.flow:stop()
		self.flow:destroy()

		self.flow = nil
	end
end

function FightShuZhenView:onClose()
	self:clearFlow()

	if self.magicItem then
		self.magicItem:destroy()

		self.magicItem = nil
	end
end

function FightShuZhenView:onDestroyView()
	return
end

return FightShuZhenView
