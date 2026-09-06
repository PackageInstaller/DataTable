-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/PetStarDetailView.lua

module("logic.extensions.starequipment.view.PetStarDetailView", package.seeall)

local PetStarDetailView = class("PetStarDetailView", ViewComponent)

function PetStarDetailView:ctor()
	PetStarDetailView.super.ctor(self)
end

function PetStarDetailView:destroyUI()
	PetStarDetailView.super.destroyUI(self)
end

function PetStarDetailView:onExitFinished()
	PetStarDetailView.super.onExitFinished(self)
end

function PetStarDetailView:onEnterFinished()
	PetStarDetailView.super.onEnterFinished(self)
end

function PetStarDetailView:unbindEvents()
	PetStarDetailView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function PetStarDetailView:bindEvents()
	PetStarDetailView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function PetStarDetailView:onExit()
	PetStarDetailView.super.onExit(self)
end

function PetStarDetailView:buildUI()
	PetStarDetailView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")

	local attrs = self:getGo("main/scrollrectAttrs/attrs")

	self._attrs = ItemEquipAttrs.New(attrs)

	local stars = self:getGo("main/scrollrectStars/stars")

	self._stars = ItemGroup.New(stars, nil, function(go, item)
		item.txtStarLv = goutil.findChildComponent(go, "txtStarLv", "Text")
		item.txtStarLv.text = string.format("%s星", item.index)

		local equips = goutil.findChild(go, "equips")

		item.equips = ItemGroup.New(equips, nil, function(equipGo, equip)
			equip.itemEquip = EquipCell.New(goutil.findChild(equipGo, "item_equip"))
		end)
	end)

	local scrollrect = goutil.findChildComponent(self.mainGO, "main/scrollrectStars", "RectTransform")

	self._sizeDelta = scrollrect.sizeDelta
	self._scrollRect = goutil.findChildComponent(self.mainGO, "main/scrollrectStars", "ScrollRect")
	self._txtAttrEmptyTips = self:getGo("main/txtAttrEmptyTips")
end

function PetStarDetailView:onEnter()
	PetStarDetailView.super.onEnter(self)

	local petMo = self:getFirstParam()
	local starLevel = petMo._starLevel
	local maxStarLv = CharacterConfig.MAX_STAR_LVL
	local maxSlotCount = CharacterConfig.MAX_STAR_SLOT_COUNT
	local propertyApps = {}
	local hasAttrAdd = false

	self._stars:updateWithLen(maxStarLv, function(star, i)
		star.equips:updateWithLen(maxSlotCount, function(equip, slotIndex)
			local equipId = CharacterConfig.instance:getRecommendEquipId(petMo.raceId, i - 1, slotIndex)
			local equipCfg = StarEquipmentConfig.instance:getEquipCfg(equipId)

			if starLevel >= i - 1 then
				if not StarEquipmentConfig.MaxStarEquipmentLv then
					local equipLv = 1
					local isActived = starLevel >= i - 1

					if starLevel == i - 1 or i == maxStarLv and starLevel >= maxStarLv - 1 then
						local equipMo = petMo:getSlotEquip(slotIndex)

						isActived = equipMo ~= nil

						if equipMo ~= nil then
							equipLv = equipMo.level
							equipId = equipMo.equipmentId
							equipCfg = StarEquipmentConfig.instance:getEquipCfg(equipMo.equipmentId)
						end
					end

					if isActived then
						local equipLvCfg = StarEquipmentConfig.instance:getEquipLvCfg(equipId, equipLv)

						table.insert(propertyApps, equipLvCfg.propertyApp)
					end

					equip.itemEquip:onSetMo(equipCfg, isActived and equipLv or 0)

					hasAttrAdd = hasAttrAdd or isActived

					uGuiUtil.setGoGrayState(equip.itemEquip.target, not isActived)
				end
			end
		end)
	end)
	self._attrs:updateAttrsWithMos(propertyApps)

	if starLevel * 140 - 10 > self._sizeDelta.y then
		offset = starLevel * 140 - self._sizeDelta.y - 10 or 0
	end

	local maxOffset = 420 - self._sizeDelta.y - 10

	settimer(0.02, function()
		self._scrollRect.verticalNormalizedPosition = (maxOffset - offset) / maxOffset
	end, nil, false)
	goutil.setActive(self._txtAttrEmptyTips, not hasAttrAdd)
end

function PetStarDetailView:_onClickClose()
	self:close()
end

return PetStarDetailView
