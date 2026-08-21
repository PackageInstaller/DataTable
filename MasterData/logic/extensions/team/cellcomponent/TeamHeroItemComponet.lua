-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/cellcomponent/TeamHeroItemComponet.lua

module("logic.extensions.team.cellcomponent.TeamHeroItemComponet", package.seeall)

local ButtonAdapter = Astral.ButtonAdapter
local M = class("TeamHeroItemComponet")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "heroMask/heroIcon")
	self._imgQuality = goutil.findChildImageComponent(self.mainGO, "imgQuality")
	self._imgCamp = goutil.findChildImageComponent(self.mainGO, "camp/imgCamp")
	self._imgCareerBg = goutil.findChildImageComponent(self.mainGO, "imgCareerDi_1")
	self._txtLv = goutil.findChildTextComponent(self.mainGO, "txtLv")
	self._career = UIBattleCareer.New(goutil.findChild(self.mainGO, "imgCareerDi"))

	local goClick = goutil.findChild(self.mainGO, "click")

	self._transform = self.mainGO.transform
	self._btnClick = Astral.ButtonAdapter.Get(goClick)
	self._btnDrag = UIPassableDragTrigger.Get(goClick)

	self._btnClick:AddClickListener(self._onClickIcon, self)
	self._btnDrag:AddBeginDragListener(self._onBeginDrag, self)
	self._btnDrag:AddDragListener(self._onDrag, self)
	self._btnDrag:AddEndDragListener(self._onEndDrag, self)

	self._handler = false
	self._heroId = false
	self._enable = false
end

function M:OnEnable()
	local transform = self.mainGO.transform

	GlobalDispatcher:addEventListener(EventType.SELECT_TEAM_HERO_EVENT, self._onSelectItem, self)
end

function M:OnDisable()
	self._handler = false

	IconLoader.clearSprite(self._imgIcon)
	GlobalDispatcher:removeEventListener(EventType.SELECT_TEAM_HERO_EVENT, self._onSelectItem, self)
end

function M:_onSelectItem(key, heroId)
	self:setSelected(self._heroMO:getId() == heroId)
end

function M:getHeroMO()
	return self._heroMO
end

function M:setHeroMO(heroMO, index)
	self._heroMO = heroMO
	self._index = index
	self._heroId = heroMO:getId()
	self._txtLv.text = heroMO:getLevel()

	self._career:setCareerAndColorType(heroMO:getCareer(), heroMO:getColorType())

	local modelCO = ModelConfig.instance:getModelConfig(heroMO:getModelId())

	IconLoader.setSprite(self._imgIcon, IconType.HeadIcon, modelCO.headIconName)
	IconLoader.setSprite(self._imgCamp, IconType.CampBattle, BattleIconName.getCampIcon(heroMO:getCamp()))
	IconLoader.setSprite(self._imgCareerBg, IconType.DynSpriteAtlas_Battle, BattleIconName.getColorTypeBg(heroMO:getColorType()))
	IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_Battle, BattleIconName.getQualityIcon(heroMO:getQuality()))

	self._isSelect = false
end

function M:setEnable(enable)
	self._enable = enable
	self._canvasGroup.alpha = enable and 1 or 0.3
end

function M:getHeroId()
	return self._heroId
end

function M:setPassToGameObject(passToGO)
	self._btnDrag:SetPassToGameObject(passToGO)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setLocalPosition(x, y)
	Astral.TransformUtil.SetLocalPos(self._transform, x, y, 0)
end

function M:setSelected(selected)
	local x, y = Astral.TransformUtil.GetAnchoredPos(self._transform, 0, 0)

	if self._isSelect and not selected then
		Astral.TransformUtil.SetAnchoredPos(self._transform, x, 0)
	elseif not self._isSelect and selected then
		Astral.TransformUtil.SetAnchoredPos(self._transform, x, 10)
	end

	self._isSelect = selected
end

function M:_onClickIcon()
	if not self:_checkEnable() then
		return
	end

	self._handler:onClickHeadItem(self)
end

function M:_onEndDrag(eventData)
	local position = eventData.position

	self._handler:onEndDragHeadItem(self, position.x, position.y)
end

local kTan = math.tan(math.rad(15))

function M:_onBeginDrag(eventData)
	local delta = eventData.delta

	if math.abs(delta.y) >= math.abs(delta.x) * kTan then
		if not self:_checkEnable() then
			return false
		end

		local position = eventData.position

		self._handler:onBeginDragHeadItem(self, position.x, position.y)

		return true
	end

	return false
end

function M:_onDrag(eventData)
	local position = eventData.position

	self._handler:onDragHeadItem(self, position.x, position.y)
end

function M:_checkEnable()
	if self._enable then
		return true
	end
end

function M:OnDestroy()
	self._btnClick:RemoveClickListener()
	self._btnDrag:RemoveBeginDragListener()
	self._btnDrag:RemoveDragListener()
	self._btnDrag:RemoveEndDragListener()
	self._btnDrag:SetPassToGameObject(nil)
	self._career:destroy()

	self._canvasGroup = nil
	self._transform = nil
	self._btnClick = nil
	self._btnDrag = nil
	self._imgIcon = nil
	self._imgQuality = nil
	self._imgCamp = nil
	self._imgCareerBg = nil
	self._txtLv = nil
	self._handler = false
	self._enable = false
	self._heroId = false
	self._heroMO = false
end

return M
