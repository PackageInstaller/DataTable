-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/equip/EquipStarUpMediator.lua

EquipStarUpMediator = class("EquipStarUpMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {}

function EquipStarUpMediator:initialize()
	super.initialize(self)
end

function EquipStarUpMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function EquipStarUpMediator:onRemove()
	super.onRemove(self)
end

function EquipStarUpMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function EquipStarUpMediator:userInject()
	self._equipSystem = self:getInjector():getInstance(DevelopSystem):getEquipSystem()
end

function EquipStarUpMediator:enterWithData(data)
	self._oldMaxLevel = data.oldMaxLevel
	self._equipId = data.equipId
	self._oldAttrList = data.oldAttrList
	self._equipData = self._equipSystem:getEquipById(self._equipId)

	self:setupView()
end

function EquipStarUpMediator:setupView()
	local main = self:getView():getChildByName("main")
	local animNode = main:getChildByName("animNode")
	local descNode = main:getChildByName("descNode")

	descNode:setOpacity(0)

	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:setPlaySpeed(1.5)
	anim:addTo(animNode, 1)
	anim:addCallbackAtFrame(39, function()
		anim:stop()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local title1 = cc.Label:createWithTTF(Strings:get("Tips_3010027"), CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(Strings:get("UITitle_EN_Tupochenggong"), TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)
	anim:addCallbackAtFrame(14, function()
		descNode:fadeIn({
			time = 0.2
		})
	end)

	local equipNode = descNode:getChildByName("equipNode")
	local rarity = self._equipData:getRarity()
	local level = self._equipData:getLevel()
	local star = self._equipData:getStar()
	local levelMax = self._equipData:getMaxLevel()
	local param = {
		id = self._equipData:getEquipId(),
		level = level,
		star = star,
		rarity = rarity
	}
	local equipIcon = IconFactory:createEquipIcon(param)

	equipIcon:addTo(equipNode):center(equipNode:getContentSize())
	equipIcon:setScale(0.8)

	local levelLabel1 = descNode:getChildByName("level1")

	levelLabel1:setString(Strings:get("Strenghten_Text78", {
		level = self._oldMaxLevel
	}))

	local levelLabel2 = descNode:getChildByName("level2")

	levelLabel2:setString(Strings:get("Strenghten_Text78", {
		level = levelMax
	}))

	local attrList = self._oldAttrList

	for i = 1, 4 do
		local attrPanel = self:getView():getChildByFullName("desc_" .. i)

		attrPanel:setVisible(false)

		local index = i

		if i > 2 then
			attrList = self._equipData:getAttrListShow()
			index = i - 2
		end

		if attrList[index] then
			attrPanel:setVisible(true)

			local attrType = attrList[index].attrType
			local attrNum = attrList[index].attrNum
			local attrName = AttributeCategory:getAttName(attrType)
			local attrTypeImage = AttrTypeImage[attrType]
			local attrImage = attrPanel:getChildByFullName("image")

			attrImage:loadTexture(attrTypeImage, 1)

			local attrText = attrPanel:getChildByFullName("text")

			attrText:setString(attrNum)

			if AttributeCategory:getAttNameAttend(attrType) ~= "" then
				attrText:setString(attrNum * 100 .. "%")
			end
		end
	end
end
