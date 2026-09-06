-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/ItemEquipAttrs.lua

module("logic.extensions.starequipment.view.ItemEquipAttrs", package.seeall)

local ItemEquipAttrs = class("ItemEquipAttrs")

function ItemEquipAttrs:ctor(target, cloneGo)
	self.mainGO = target
	self._attrs = ItemGroup.New(target, cloneGo, function(go, item)
		item.txtName = goutil.findChildComponent(go, "txtName", "Text")
		item.txtCurVal = goutil.findChildComponent(go, "txtCurVal", "Text")
		item.txtTargetVal = goutil.findChildComponent(go, "txtTargetVal", "Text")

		goutil.setActive(go, false)
	end)
	self._showAttrs = {}
end

function ItemEquipAttrs:updateAttrs(propertyApp)
	local t = string.split(propertyApp, "#")
	local attrs = {}

	for _, str in ipairs(t) do
		local t2 = string.split(str, "+")

		attrs[t2[1]] = t2[2]
	end

	self:_updateAttrs(attrs, {})
end

function ItemEquipAttrs:updateAttrsWithMos(propertyApps)
	local attrs = {}

	for _, propertyApp in ipairs(propertyApps) do
		local t = string.split(propertyApp, "#")

		for _, str in ipairs(t) do
			local t2 = string.split(str, "+")
			local key = t2[1]
			local value = t2[2]

			attrs[key] = attrs[key] == nil and value or checknumber(attrs[key]) + checknumber(value)
		end
	end

	self:_updateAttrs(attrs, {})
end

function ItemEquipAttrs:setColor(r, g, b)
	for _, item in pairs(self._showAttrs) do
		Game.TextUtil.SetColorRGBA(item.txtName, r, g, b, 1)
		Game.TextUtil.SetColorRGBA(item.txtCurVal, r, g, b, 1)
	end
end

function ItemEquipAttrs:onSetMoBreak(equipId, targetId, equipLv)
	local curAttrs = StarEquipmentConfig.instance:getEquipAttrs(equipId, equipLv)
	local targetAttrs = StarEquipmentConfig.instance:getEquipAttrs(targetId, equipLv)

	self:_updateAttrs(curAttrs, targetAttrs)
end

function ItemEquipAttrs:onSetMoStarLvup(raceId, starLevel)
	local curAttrs
	local equipLv = StarEquipmentConfig.MaxStarEquipmentLv

	for slotIndex = 1, CharacterConfig.MAX_STAR_SLOT_COUNT do
		local equipId = CharacterConfig.instance:getRecommendEquipId(raceId, starLevel, slotIndex)
		local attrs = StarEquipmentConfig.instance:getEquipAttrs(equipId, equipLv)

		if curAttrs == nil then
			curAttrs = attrs
		else
			for k, v in pairs(attrs) do
				curAttrs[k] = curAttrs[k] == nil and v or checknumber(curAttrs[k]) + checknumber(v)
			end
		end
	end

	self:_updateAttrs(curAttrs or {}, {})
end

function ItemEquipAttrs:onSetMo(equipId, curLv, targetLv)
	curLv = checknumber(curLv)
	targetLv = checknumber(targetLv)

	local curAttrs = StarEquipmentConfig.instance:getEquipAttrs(equipId, curLv)

	self:_updateAttrs(curAttrs, (curLv < targetLv or nil) and StarEquipmentConfig.instance:getEquipAttrs(equipId, targetLv))
end

function ItemEquipAttrs:onSetMoRuneLvup(runeId, curLv, targetLv)
	curLv = checknumber(curLv)
	targetLv = checknumber(targetLv)

	local curAttrs = RuneConfig.instance:getRuneAttrs(runeId, curLv)

	self:_updateAttrs(curAttrs, (curLv < targetLv or nil) and SRuneConfig.instance:getRuneAttrs(runeId, targetLv))
end

function ItemEquipAttrs:_updateAttrs(curAttrs, targetAttrs)
	self:clearShowAttrs()

	local attr

	for key, value in pairs(curAttrs) do
		if string.find(key, "率") then
			value = checknumber(value) * 100 .. "%"
		end

		if self._showAttrs[key] == nil then
			self._showAttrs[key] = self._attrs:_getFreeItem()
			attr = self._showAttrs[key]
		end

		if attr ~= nil then
			attr = self._showAttrs[key]
			self._showAttrs[key].txtName.text = ConstString.langAttr(key)
			attr.txtCurVal.text = "+" .. value

			GameUtil.SetActive(attr.txtTargetVal, false)
		end
	end

	for key, value in pairs(targetAttrs) do
		if string.find(key, "率") then
			value = checknumber(value) * 100 .. "%"
		end

		if self._showAttrs[key] ~= nil then
			local txtTargetVal = self._showAttrs[key].txtTargetVal

			GameUtil.SetActive(txtTargetVal, true)

			if txtTargetVal ~= nil then
				txtTargetVal.text = "+" .. value
			end
		else
			self._showAttrs[key] = self._attrs:_getFreeItem()

			if self._showAttrs[key] ~= nil then
				self._showAttrs[key].txtName.text = "(新) " .. key
				self._showAttrs[key].txtCurVal.text = value
			end
		end
	end
end

function ItemEquipAttrs:clearShowAttrs()
	for _, attr in pairs(self._showAttrs) do
		goutil.setActive(attr.mainGO, false)
	end

	self._showAttrs = {}
end

return ItemEquipAttrs
