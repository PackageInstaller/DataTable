-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/item/ItemCell.lua

module("logic.extensions.material.proxy.item.ItemCell", package.seeall)

local ItemCell = class("ItemCell", MaterialCell)

function ItemCell:ctor(target)
	ItemCell.super.ctor(self, target)

	self.icon = goutil.findChild(self.target, "ImgIcon")
	self.iconBg = goutil.findChild(self.target, "ImgBg"):GetComponent("UIImageSpriteChange")
	self.txtNum = goutil.findChild(self.target, "TxtNum"):GetComponent("Text")
	self.Image = goutil.findChild(self.target, "Image")
	self.selected = goutil.findChild(self.target, "Select")
	self.tag = goutil.findChild(self.target, "tag")
	self.exclSptGo = goutil.findChild(self.target, "exclSptGo")
	self.exclIcon = goutil.findChild(self.target, "exclSptGo/exclIcon")
	self.hasDestroy = goutil.findChild(self.target, "hasDestroy")
	self.withTag = goutil.findChild(self.target, "withTag")

	GameUtil.SetActive(self.tag, false)

	self.tagGift = goutil.findChild(self.target, "tag_gift")

	GameUtil.SetActive(self.tagGift, false)

	self.imgBg = goutil.findChildComponent(self.target, "ImgBg", "Image")
	self._imgTagColorChange = goutil.findChildComponent(self.target, "Img_Tag", "UIImageColorChange")
	self._txtTag = goutil.findChildTextComponent(self._imgTagColorChange.gameObject, "Text")
	self.topGo = goutil.findChild(self.target, "topGo")

	self:dispose()
end

function ItemCell:setBgActive(isActive)
	self.imgBg.enabled = isActive
end

function ItemCell:setData(data)
	self.data = data

	self:setNum(0)

	if data ~= nil then
		self:setNum(data.num)
	end
end

function ItemCell:setNum(allNum, useNum)
	self.num = allNum or 1

	if self.num <= 0 then
		self.txtNum.text = ""

		GameUtil.SetActive(self.Image, false)

		return
	end

	GameUtil.SetActive(self.Image, true)

	self.txtNum.text = useNum and useNum >= 0 and useNum .. "/" .. self.num or tostring(self.num)
end

function ItemCell:setWithTag(state)
	GameUtil.SetActive(self.withTag, state == 1)
end

function ItemCell:setNumStr(str)
	GameUtil.SetActive(self.Image, str and str ~= "")

	self.txtNum.text = str
end

function ItemCell:setNumBg(torf)
	GameUtil.SetActive(self.Image, torf)
end

function ItemCell:setUiOfMock(isMock)
	GameUtil.SetActive(self.hasDestroy, isMock)
end

function ItemCell:setCfgData(cfg)
	ItemCell.super.setCfgData(self, cfg)
	GameUtil.addClickHandler(self.target, self._OnClick, self)
	GameUtil.SetActive(self.tag, false)
	GameUtil.SetActive(self.tagGift, false)
	self.icon:SetActive(false)
	self.iconBg:SetState(0)
	goutil.setActive(self._imgTagColorChange.gameObject, false)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end

	MaterialMgr.clearIcon(self.exclIcon)
	GameUtil.SetActive(self.exclSptGo, false)

	if cfg then
		MaterialMgr.setIcon(self.icon, self.type, cfg.id)
		self.icon:SetActive(true)
		self.iconBg:SetState(1 + (cfg.quality or 0))

		self._effSSR = self:playRareEffect(1 + (cfg.quality or 0), self.topGo)

		if checknumber(cfg.subType) == MatType.Item_Piece then
			GameUtil.SetActive(self.tag, true)
		elseif checknumber(cfg.subType) == MatType.Item_GoodFeel then
			GameUtil.SetActive(self.tagGift, true)
		elseif checknumber(cfg.subType) == MatType.Item_PetSoul then
			local itemExtData = ItemConfig.instance:getAwakenItemExtCfgById(cfg.id)

			if itemExtData then
				local isHasFitPet = itemExtData.race > 0

				if isHasFitPet then
					MaterialMgr.setIcon(self.exclIcon, MatType.Pet, itemExtData.race, nil, nil)
				end

				GameUtil.SetActive(self.exclSptGo, isHasFitPet)
			else
				printError(string.format("精灵之魂道具缺少升星额外信息配置( subType=%s, id=%s )", cfg.subType, cfg.id))
			end
		end
	end

	self:setWithTag(0)
end

function ItemCell:_getCardTag(itemExtCfg)
	if itemExtCfg.isSameRace then
		local rare = itemExtCfg.level

		if rare == GameEnum.PetRare.UR then
			return GameEnum.AwakenCardTag.SameRaceIdUR
		else
			return GameEnum.AwakenCardTag.SameRaceIdSSR
		end
	else
		return GameEnum.Races[itemExtCfg.attr]
	end

	return 1
end

function ItemCell:OnDestroy()
	ItemCell.super.OnDestroy(self)

	self.target = nil
	self.data = nil
	self._clickBack = nil
end

function ItemCell:setSelected(isSelected)
	self.selected.gameObject:SetActive(isSelected)
end

function ItemCell:setCallBack(cb)
	self._clickBack = cb
end

function ItemCell:_OnClick()
	print(">>>>>>>>>>>item cell click")
	GameUtil.callBack(self._clickBack, self)

	if self.autoTips then
		print(">>>>>>>>>>>open tips")
		CommonTipsMgr.instance:openMaterialTips(self.icon, self.type, self.id, 0)
	end
end

function ItemCell:setGray(isGray)
	uGuiUtil.setImageGrayStateRecursive(self.target, isGray)
	self:setEffStatus(not isGray)
end

function ItemCell:setEffStatus(flag)
	GameUtil.SetActive(self.topGo, flag)
end

function ItemCell:dispose()
	ItemCell.super.dispose(self)

	self._clickBack = nil

	self:setSelected(false)
	self.icon:SetActive(false)
	self.iconBg:SetState(0)
	self:setBgActive(true)
	self:setUiOfMock(false)
	self:setNum(0)
	MaterialMgr.clearIcon(self.icon)
	UIEffectManager.instance:stopEffect(self._effSSR)

	self._effSSR = nil

	self:setEffStatus(true)
	MaterialMgr.clearIcon(self.exclIcon)
	GameUtil.SetActive(self.exclSptGo, false)
	self:setWithTag(0)
end

return ItemCell
