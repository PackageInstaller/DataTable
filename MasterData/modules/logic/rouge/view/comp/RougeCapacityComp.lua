-- chunkname: @modules/logic/rouge/view/comp/RougeCapacityComp.lua

module("modules.logic.rouge.view.comp.RougeCapacityComp", package.seeall)

local RougeCapacityComp = class("RougeCapacityComp", LuaCompBase)

RougeCapacityComp.SpriteType1 = "rouge_team_volume_1"
RougeCapacityComp.SpriteType2 = "rouge_team_volume_2"
RougeCapacityComp.SpriteType3 = "rouge_team_volume_3"

function RougeCapacityComp:init(go)
	self._go = go
end

function RougeCapacityComp.Add(go, curNum, maxNum, autoFindNodes, notUsedType)
	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, RougeCapacityComp)

	comp:setCurNum(curNum)
	comp:setMaxNum(maxNum)

	if autoFindNodes then
		comp:autoFindNodes()
	end

	comp:setSpriteType(nil, notUsedType)
	comp:initCapacity()

	return comp
end

function RougeCapacityComp:getCurNum()
	return self._curNum
end

function RougeCapacityComp:getMaxNum()
	return self._maxNum
end

function RougeCapacityComp:updateCurAndMaxNum(curNum, maxNum)
	self._curNum = curNum
	self._maxNum = maxNum

	self:_refreshImageList()
end

function RougeCapacityComp:updateCurNum(num)
	self._curNum = num

	self:_refreshImageList()
end

function RougeCapacityComp:updateMaxNum(num)
	self._maxNum = num

	self:_refreshImageList()
end

function RougeCapacityComp:updateMaxNumAndOpaqueNum(num, opaqueNum)
	self._opaqueNum = opaqueNum

	self:updateMaxNum(num)
end

function RougeCapacityComp:showChangeEffect(value)
	self._showChangeEffect = value
end

function RougeCapacityComp:setPoint(pointGo)
	self._pointGo = pointGo
end

function RougeCapacityComp:setTxt(txt)
	self._txt = txt
end

function RougeCapacityComp:autoFindNodes()
	self._pointGo = gohelper.findChild(self._go, "point")

	gohelper.setActive(self._pointGo, false)

	self._txt = gohelper.findChildText(self._go, "#txt_num")

	if not self._pointGo then
		logError("RougeCapacityComp autoFindNodes 请检查脚本是否attach在volume上，以及节点目录是否正确")
	end
end

function RougeCapacityComp:setCurNum(num)
	if self._curNum then
		return
	end

	self._curNum = num
end

function RougeCapacityComp:setMaxNum(num)
	if self._maxNum then
		return
	end

	self._maxNum = num
end

function RougeCapacityComp:setSpriteType(usedType, notUsedType)
	self._usedSpriteType = usedType
	self._notUsedSpriteType = notUsedType
end

function RougeCapacityComp:getUsedSpriteType()
	self._usedSpriteType = self._usedSpriteType or RougeCapacityComp.SpriteType3

	return self._usedSpriteType
end

function RougeCapacityComp:getNotUsedSpriteType()
	self._notUsedSpriteType = self._notUsedSpriteType or RougeCapacityComp.SpriteType1

	return self._notUsedSpriteType
end

function RougeCapacityComp:setTxtFormat(notFullFormat, fullFormat)
	self._notFullFormat = notFullFormat
	self._fullFormat = fullFormat
end

function RougeCapacityComp:getFullFormat()
	self._fullFormat = self._fullFormat or "<#D97373>%s</color>/%s"

	return self._fullFormat
end

function RougeCapacityComp:getNotFullFormat()
	self._notFullFormat = self._notFullFormat or "<#E99B56>%s</color>/%s"

	return self._notFullFormat
end

function RougeCapacityComp:initCapacity()
	if self._imageList then
		return
	end

	self._imageList = self:getUserDataTb_()

	self:_refreshImageList()
end

function RougeCapacityComp:_getPointInfo(index)
	local t = self._imageList[index]

	if not t then
		local pointGo = gohelper.cloneInPlace(self._pointGo)

		gohelper.setActive(pointGo, true)

		local image = pointGo:GetComponent(gohelper.Type_Image)

		t = self:getUserDataTb_()
		self._imageList[index] = t
		t.image = image
		t.yellow = gohelper.findChild(pointGo, "yellow")
	end

	return t
end

function RougeCapacityComp:_refreshImageList()
	if not self._imageList or not self._maxNum then
		return
	end

	local hasChanged = false

	if not self._curNum then
		local curNum = 0
		local isChangeNum = curNum ~= self._prevNum

		self._prevNum = curNum

		local maxNum = self._maxNum

		if not self._opaqueNum then
			local opaqueNum = maxNum

			maxNum = math.max(maxNum, #self._imageList)

			for i = 1, maxNum do
				local pointInfo = self:_getPointInfo(i)
				local image = pointInfo.image
				local isShow = i <= self._maxNum

				gohelper.setActive(image, isShow)

				if isShow then
					local showUsed = i <= curNum
					local var_23_2

					if showUsed and self._showChangeEffect and isChangeNum then
						gohelper.setActive(pointInfo.yellow, false)
						gohelper.setActive(pointInfo.yellow, true)

						hasChanged = true
						var_23_2 = showUsed and self:getUsedSpriteType() or self:getNotUsedSpriteType()
					end

					UISpriteSetMgr.instance:setRougeSprite(image, var_23_2)

					if self._opaqueNum ~= nil then
						local color = image.color

						color.a = i <= opaqueNum and 1 or 0.4
						image.color = color
					end
				end
			end

			if hasChanged then
				AudioMgr.instance:trigger(AudioEnum.UI.PointLight)
			end

			if self._txt then
				local txtFormat = curNum >= self._maxNum and self:getFullFormat() or self:getNotFullFormat()

				self._txt.text = string.format(txtFormat, curNum, self._maxNum)
			end
		end
	end
end

return RougeCapacityComp
