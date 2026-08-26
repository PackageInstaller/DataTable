-- chunkname: @modules/logic/season/view3_0/Season3_0CelebrityCardItem.lua

module("modules.logic.season.view3_0.Season3_0CelebrityCardItem", package.seeall)

local Season3_0CelebrityCardItem = class("Season3_0CelebrityCardItem", LuaCompBase)

Season3_0CelebrityCardItem.AssetPath = "ui/viewres/v3a0_season/seasoncelebritycarditem.prefab"

function Season3_0CelebrityCardItem:init(go, equipId, params)
	self.go = go
	self._showTag = false
	self._showNewFlag = params and params.showNewFlag
	self._showNewFlag2 = params and params.showNewFlag2
	self._targetFlagUIScale = params and params.targetFlagUIScale
	self._targetFlagUIPosX = params and params.targetFlagUIPosX
	self._targetFlagUIPosY = params and params.targetFlagUIPosY
	self._noClick = params and params.noClick
	self._gorares = {}

	self:reset(equipId)
end

function Season3_0CelebrityCardItem:_cardLoaded()
	self._cardGo = self._resLoader:getInstGO()
	self._icon = MonoHelper.addNoUpdateLuaComOnceToGo(self._cardGo, Season3_0CelebrityCardEquip)

	if not self._noClick then
		self._icon:setClickCall(self.onBtnClick, self)
	end

	self:_setItem()
end

function Season3_0CelebrityCardItem:onBtnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.EquipCard, self._equipId)
end

function Season3_0CelebrityCardItem:_setItem()
	self._icon:updateData(self._equipId)
	self._icon:setShowTag(self._showTag)
	self._icon:setShowNewFlag(self._showNewFlag)
	self._icon:setShowNewFlag2(self._showNewFlag2)
	self._icon:setFlagUIScale(self._targetFlagUIScale)
	self._icon:setFlagUIPos(self._targetFlagUIPosX, self._targetFlagUIPosY)
	self._icon:setColorDark(self._colorDarkEnable)

	local isEmpty = not self._equipId or self._equipId == 0

	self:setVisible(not isEmpty)
end

function Season3_0CelebrityCardItem:showTag(enable)
	self._showTag = enable

	if self._icon then
		self._icon:setShowTag(enable)
	end
end

function Season3_0CelebrityCardItem:showProbability(enable)
	self._showTag = enable

	if self._icon then
		self._icon:setShowProbability(enable)
	end
end

function Season3_0CelebrityCardItem:showNewFlag(enable)
	self._showNewFlag = enable

	if self._icon then
		self._icon:setShowNewFlag(enable)
	end
end

function Season3_0CelebrityCardItem:showNewFlag2(enable)
	self._showNewFlag2 = enable

	if self._icon then
		self._icon:setShowNewFlag2(enable)
	end
end

function Season3_0CelebrityCardItem:reset(equipId)
	self._equipId = equipId
	self._gocarditem = self._gocarditem or gohelper.create2d(self.go, "cardItem")

	if not self._cardGo and not self._resloader then
		self._resLoader = PrefabInstantiate.Create(self._gocarditem)

		local assetPath = Season3_0CelebrityCardItem.AssetPath

		self._resLoader:startLoad(assetPath, self._cardLoaded, self)
	end

	if self._cardGo then
		self:_setItem()
	end
end

function Season3_0CelebrityCardItem:setColorDark(enable)
	self._colorDarkEnable = enable

	if self._icon then
		self._icon:setColorDark(enable)
	end
end

function Season3_0CelebrityCardItem:setVisible(visible)
	if self._isVisible == visible then
		return
	end

	self._isVisible = visible

	gohelper.setActive(self._gocarditem, self._isVisible)
end

function Season3_0CelebrityCardItem:destroy()
	if self._icon then
		self._icon:disposeUI()

		self._icon = nil
	end

	if self._gocarditem then
		gohelper.destroy(self._gocarditem)

		self._gocarditem = nil
	end

	if self._cardGo then
		self._cardGo = nil
	end

	if self._resloader then
		self._resloader:dispose()

		self._resloader = nil
	end
end

return Season3_0CelebrityCardItem
