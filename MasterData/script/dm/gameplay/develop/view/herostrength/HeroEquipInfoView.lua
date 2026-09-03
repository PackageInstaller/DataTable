-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroEquipInfoView.lua

HeroEquipInfoView = class("HeroEquipInfoView", DisposableObject, _M)

HeroEquipInfoView:has("_view", {
	is = "r"
})
HeroEquipInfoView:has("_info", {
	is = "r"
})
HeroEquipInfoView:has("_mediator", {
	is = "r"
})

local componentPath = "asset/ui/HeroEquipInfo.csb"
local lockImage = {
	"yinghun_icon_unlock.png",
	"yinghun_icon_lock.png"
}
local kAttrPosY = {
	{
		33
	},
	{
		49,
		17
	}
}

function HeroEquipInfoView:initialize(info)
	self._info = info
	self._mediator = info.mediator
	self._developSystem = self._mediator:getInjector():getInstance("DevelopSystem")
	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._equipSystem = self._developSystem:getEquipSystem()

	self:createView(info)
	super.initialize(self)
end

function HeroEquipInfoView:dispose()
	super.dispose(self)
end

function HeroEquipInfoView:createView(info)
	self._view = info.mainNode or cc.CSLoader:createNode(componentPath)
	self._equipPanel = self._view:getChildByFullName("equipPanel")
	self._nodeDesc = self._equipPanel:getChildByFullName("nodeDesc")
	self._nodeAttr = self._equipPanel:getChildByFullName("nodeAttr")
	self._nodeSkill = self._equipPanel:getChildByFullName("nodeSkill")
	self.text1 = self._nodeAttr:getChildByFullName("text")
	self.text2 = self._nodeSkill:getChildByFullName("text")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		for i = 1, 2 do
			local str = self["text" .. i]:getString()

			str = string.split(str, " ")

			local width = 0

			for k, v in pairs(str) do
				if width < #v then
					width = #v
				end
			end

			width = width * 10 > 75 and 75 or width * 10

			self["text" .. i]:setContentSize(cc.size(width, 60))
		end
	end

	self._skillListView = self._nodeSkill:getChildByFullName("listView")

	self._skillListView:setScrollBarEnabled(false)

	self._strengthenBtn = self._equipPanel:getChildByFullName("btnPanel.strengthenBtn")
	self._changeBtn = self._equipPanel:getChildByFullName("btnPanel.changeBtn")
	self._lockBtn = self._equipPanel:getChildByFullName("lockBtn")

	self._lockBtn:addClickEventListener(function()
		self._mediator:onClickEquipLock()
	end)

	local animNode1 = self._nodeAttr:getChildByFullName("animNode")

	if not animNode1:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(animNode1)
		anim:setName("BgAnim")
		anim:offset(0, -5)
	end

	animNode1:getChildByFullName("BgAnim"):gotoAndPlay(1)

	local animNode2 = self._nodeSkill:getChildByFullName("animNode")

	if not animNode2:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(animNode2)
		anim:setName("BgAnim")
		anim:offset(0, -4)
	end

	animNode2:getChildByFullName("BgAnim"):gotoAndPlay(1)

	local loadingBar = self._nodeDesc:getChildByFullName("exp.loadingBar")

	loadingBar:setScale9Enabled(true)
	loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))

	local desc1 = self._nodeAttr:getChildByFullName("desc_1")
	local desc2 = self._nodeAttr:getChildByFullName("desc_2")

	GameStyle:setCommonOutlineEffect(desc1:getChildByFullName("name"))
	GameStyle:setCommonOutlineEffect(desc2:getChildByFullName("name"))
	GameStyle:setCommonOutlineEffect(desc1:getChildByFullName("text"), 142.8)
	GameStyle:setCommonOutlineEffect(desc2:getChildByFullName("text"), 142.8)
	self._strengthenBtn:setVisible(CommonUtils.GetSwitch("fn_equip_strengthen"))
end

function HeroEquipInfoView:refreshEquipInfo(data)
	self:refreshData(data)
	self:refreshLock()
	self:refreshDesc()
	self:refreshAttr()
	self:refreshSkill()
end

function HeroEquipInfoView:refreshData(data)
	data = data or {}
	self._heroId = data.heroId or self._heroId
	self._equipType = data.equipType
	self._equipId = data.equipId or self._equipId
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._equipData = self._equipSystem:getEquipById(self._equipId)
end

function HeroEquipInfoView:refreshLock()
	local unlock = self._equipData:getUnlock()

	if unlock then
		if not lockImage[1] then
			local image = lockImage[2]

			self._lockBtn:getChildByFullName("image"):loadTexture(image, 1)
		end
	end
end

function HeroEquipInfoView:showLockTip()
	if self._equipData:getUnlock() then
		local var_10_0 = Strings:get("Equip_Success_Unlock")

		if not var_10_0 then
			var_10_0 = Strings:get("Equip_Success_Lock")

			local tip = var_10_0

			self._mediator:dispatch(ShowTipEvent({
				tip = tip
			}))
		end
	end
end

function HeroEquipInfoView:refreshDesc()
	local isMaxLevel = self._equipData:isMaxLevel()
	local name = self._equipData:getName()
	local rarity = self._equipData:getRarity()
	local level = self._equipData:getLevel()
	local levelMax = self._equipData:getMaxLevel()
	local star = self._equipData:getStar()
	local curExp = self._equipData:getExp()
	local targetExp = self._equipData:getLevelNextExp()
	local equipOccu = self._equipData:getOccupation()
	local occupationDesc = self._equipData:getOccupationDesc()
	local occupationType = self._equipData:getOccupationType()
	local node = self._nodeDesc:getChildByFullName("node")

	node:removeAllChildren()

	local param = {
		id = self._equipData:getEquipId(),
		level = level,
		star = star,
		rarity = rarity
	}
	local equipIcon = IconFactory:createEquipIcon(param)

	equipIcon:addTo(node):center(node:getContentSize())
	equipIcon:setScale(0.76)

	local nameLabel = self._nodeDesc:getChildByFullName("name")

	nameLabel:setString(name)

	local levelLabel = self._nodeDesc:getChildByFullName("level")

	levelLabel:setString(Strings:get("Strenghten_Text78", {
		level = level .. "/" .. levelMax
	}))

	local loadingBar = self._nodeDesc:getChildByFullName("exp.loadingBar")

	if isMaxLevel then
		loadingBar:setPercent(100)
	end

	local limitDesc = self._nodeDesc:getChildByFullName("text")
	local limitNode = self._nodeDesc:getChildByFullName("limit")

	limitNode:removeAllChildren()

	if occupationDesc ~= "" then
		limitDesc:setString(Strings:get("Equip_UI24") .. " " .. Strings:get(occupationDesc))
	else
		limitDesc:setString(Strings:get("Equip_UI24"))

		if occupationType == nil or occupationType == 0 then
			if equipOccu then
				for i = 1, #equipOccu do
					local occupationName, occupationIcon = GameStyle:getHeroOccupation(equipOccu[i])
					local image = ccui.ImageView:create(occupationIcon)

					image:setAnchorPoint(cc.p(0, 0.5))
					image:setPosition(cc.p(40 * (i - 1), 0))
					image:setScale(0.5)
					image:addTo(limitNode)
				end
			end
		elseif occupationType == 1 and equipOccu then
			for i = 1, #equipOccu do
				local heroInfo = {
					id = IconFactory:getRoleModelByKey("HeroBase", equipOccu[i])
				}
				local headImgName = IconFactory:createRoleIconSpriteNew(heroInfo)

				headImgName:setScale(0.2)

				headImgName = IconFactory:addStencilForIcon(headImgName, 2, cc.size(31, 31))

				headImgName:setAnchorPoint(cc.p(0, 0.5))
				headImgName:setPosition(cc.p(40 * (i - 1), 0))
				headImgName:addTo(limitNode)
			end
		end
	end

	local hasRed = self._heroSystem:hasRedPointByEquipStarUp(self._heroId, self._equipType)
	local redPoint = self._strengthenBtn:getChildByName("RedPoint")

	if redPoint then
		redPoint:setVisible(hasRed)
	elseif hasRed then
		redPoint = ccui.ImageView:create(IconFactory.redPointPath, 1)

		redPoint:addTo(self._strengthenBtn):posite(48, 18):setScale(0.8)
		redPoint:setName("RedPoint")
	end

	local hasRed_1 = self._heroSystem:hasRedPointByEquipReplace(self._heroId, self._equipType)
	local redPoint_1 = self._changeBtn:getChildByName("RedPoint")

	if redPoint_1 then
		redPoint_1:setVisible(hasRed_1)
	elseif hasRed_1 then
		redPoint_1 = ccui.ImageView:create(IconFactory.redPointPath, 1)

		redPoint_1:addTo(self._changeBtn):posite(48, 18):setScale(0.8)
		redPoint_1:setName("RedPoint")
	end
end

function HeroEquipInfoView:refreshAttr()
	local attrList = self._equipData:getAttrListShow()
	local length = #attrList
	local posY = kAttrPosY[length]

	for i = 1, 2 do
		local attrPanel = self._nodeAttr:getChildByFullName("desc_" .. i)

		attrPanel:setVisible(false)

		if attrList[i] then
			attrPanel:setVisible(true)

			if posY and posY[i] then
				attrPanel:setPositionY(posY[i])
			end

			local attrType = attrList[i].attrType
			local attrNum = attrList[i].attrNum
			local attrImage = attrPanel:getChildByFullName("image")

			attrImage:loadTexture(AttrTypeImage[attrType], 1)

			local attrText = attrPanel:getChildByFullName("text")

			attrText:setString(attrNum)

			if AttributeCategory:getAttNameAttend(attrType) ~= "" then
				attrText:setString(attrNum * 100 .. "%")
			end

			local name = attrPanel:getChildByFullName("name")

			name:setString(AttributeCategory:getAttName(attrType))
		end
	end
end

function HeroEquipInfoView:refreshSkill()
	local skillName = self._nodeSkill:getChildByFullName("name")
	local skillLevel = self._nodeSkill:getChildByFullName("level")
	local skillLock = self._nodeSkill:getChildByFullName("skillLock")

	self._skillListView:removeAllItems()

	local equipData = self._equipData
	local isHaveSkill = equipData:isHaveSkill()

	skillName:setVisible(isHaveSkill)
	skillLevel:setVisible(isHaveSkill)
	self._skillListView:setVisible(isHaveSkill)
	skillLock:setVisible(not isHaveSkill)

	local skillAttr = self._equipData:getSkill()

	if isHaveSkill and skillAttr then
		local name = skillAttr:getName()
		local level = skillAttr:getLevel()

		skillName:setString(name)

		local width = self._skillListView:getContentSize().width
		local desc = skillAttr:getSkillDesc()

		if level == 0 then
			desc = skillAttr:getSkillDesc({
				fontColor = "#7B7474"
			})

			local unlockLevel = equipData:getUnLockSkillLevel()
			local tip = Strings:get("Hero_EquipUnactive")

			skillLevel:setString(tip)
			skillLevel:setColor(cc.c3b(147, 147, 147))
		else
			skillLevel:setColor(cc.c3b(255, 255, 255))

			if equipData:isSkillMaxLevel() then
				skillLevel:setString(Strings:get("Strenghten_Text79"))
			else
				skillLevel:setString(Strings:get("Strenghten_Text78", {
					level = level
				}))
			end
		end

		skillLevel:setPositionX(skillName:getPositionX() + skillName:getContentSize().width + 5)

		local label = ccui.RichText:createWithXML(desc, {})

		label:renderContent(width, 0)
		label:setAnchorPoint(cc.p(0, 0))
		label:setPosition(cc.p(0, 0))

		local height = label:getContentSize().height
		local newPanel = ccui.Layout:create()

		newPanel:setContentSize(cc.size(width, height))
		label:addTo(newPanel)
		self._skillListView:pushBackCustomItem(newPanel)
	end
end
