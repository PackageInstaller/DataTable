-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0CelebrityCardItem.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0CelebrityCardItem", package.seeall)

local Season123_2_0CelebrityCardItem = class("Season123_2_0CelebrityCardItem", LuaCompBase)

Season123_2_0CelebrityCardItem.AssetPath = "ui/viewres/seasonver/v2a0_act123/season123celebritycarditem.prefab"

function Season123_2_0CelebrityCardItem:init(go, equipId, params)
	self.go = go
	self._equipId = equipId

	local assetPath = Season123_2_0CelebrityCardItem.AssetPath

	self._showTag = false
	self._showNewFlag = params and params.showNewFlag
	self._showNewFlag2 = params and params.showNewFlag2
	self._targetFlagUIScale = params and params.targetFlagUIScale
	self._targetFlagUIPosX = params and params.targetFlagUIPosX
	self._targetFlagUIPosY = params and params.targetFlagUIPosY
	self._noClick = params and params.noClick
	self._gorares = {}
	self._gocarditem = gohelper.create2d(self.go, "cardItem")
	self._resLoader = PrefabInstantiate.Create(self._gocarditem)

	self._resLoader:startLoad(assetPath, self.handleCardLoaded, self)
end

function Season123_2_0CelebrityCardItem:handleCardLoaded()
	self._cardGo = self._resLoader:getInstGO()
	self._icon = MonoHelper.addNoUpdateLuaComOnceToGo(self._cardGo, Season123_2_0CelebrityCardEquip)

	if not self._noClick then
		self._icon:setClickCall(self.onBtnClick, self)
	end

	self:refreshItem()
end

function Season123_2_0CelebrityCardItem:onBtnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Season123EquipCard, self._equipId)
end

function Season123_2_0CelebrityCardItem:refreshItem()
	self._icon:updateData(self._equipId)
	self._icon:setShowTag(self._showTag)
	self._icon:setShowNewFlag(self._showNewFlag)
	self._icon:setShowNewFlag2(self._showNewFlag2)
	self._icon:setFlagUIScale(self._targetFlagUIScale)
	self._icon:setFlagUIPos(self._targetFlagUIPosX, self._targetFlagUIPosY)
	self._icon:setColorDark(self._colorDarkEnable)
end

function Season123_2_0CelebrityCardItem:showTag(enable)
	self._showTag = enable

	if self._icon then
		self._icon:setShowTag(enable)
	end
end

function Season123_2_0CelebrityCardItem:showProbability(enable)
	self._showTag = enable

	if self._icon then
		self._icon:setShowProbability(enable)
	end
end

function Season123_2_0CelebrityCardItem:showNewFlag(enable)
	self._showNewFlag = enable

	if self._icon then
		self._icon:setShowNewFlag(enable)
	end
end

function Season123_2_0CelebrityCardItem:showNewFlag2(enable)
	self._showNewFlag2 = enable

	if self._icon then
		self._icon:setShowNewFlag2(enable)
	end
end

function Season123_2_0CelebrityCardItem:reset(equipId)
	self._equipId = equipId

	if self._cardGo then
		self:refreshItem()
	end
end

function Season123_2_0CelebrityCardItem:setColorDark(enable)
	self._colorDarkEnable = enable

	if self._icon then
		self._icon:setColorDark(enable)
	end
end

function Season123_2_0CelebrityCardItem:destroy()
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

return Season123_2_0CelebrityCardItem
