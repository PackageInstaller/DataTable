-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/ChangeTeamModelMediator.lua

ChangeTeamModelMediator = class("ChangeTeamModelMediator", DmPopupViewMediator, _M)

ChangeTeamModelMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ChangeTeamModelMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

local kHeroRarityBgAnim = {
	[15] = "spzong_urequipeff",
	[13] = "srzong_yingxiongxuanze",
	[14] = "ssrzong_yingxiongxuanze"
}

function ChangeTeamModelMediator:initialize()
	super.initialize(self)
end

function ChangeTeamModelMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function ChangeTeamModelMediator:onRemove()
	super.onRemove(self)
end

function ChangeTeamModelMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")
	self._listPanel = self._main:getChildByName("teamList")
	self._teamClone = self:getView():getChildByName("teamClone")
	self._teamPetClone = self:getView():getChildByName("teamPetClone")

	self._listPanel:setScrollBarEnabled(false)

	local bgNode = self._main:getChildByFullName("title_node")
	local tempNode = bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onTouchMaskLayer, self)
		},
		title = Strings:get("Activity_FastTeamTitle"),
		title1 = Strings:get("Activity_FastTeamTitleEN")
	})

	self.mapEventListener(self, self:getEventDispatcher(), EVT_ARENA_CHANGE_TEAM_SUCC, self, self.refreshView)
end

function ChangeTeamModelMediator:enterWithData(data)
	self:initData()
	self:initView()
end

function ChangeTeamModelMediator:initData()
	self._teamList = self._developSystem:getAllUnlockTeams()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
end

function ChangeTeamModelMediator:getHeroInfoById(id)
	local heroInfo = self._heroSystem:getHeroById(id)

	if not heroInfo then
		return nil
	end

	return {
		id = heroInfo:getId(),
		level = heroInfo:getLevel(),
		star = heroInfo:getStar(),
		quality = heroInfo:getQuality(),
		rareity = heroInfo:getRarity(),
		qualityLevel = heroInfo:getQualityLevel(),
		name = heroInfo:getName(),
		roleModel = heroInfo:getModel(),
		type = heroInfo:getType(),
		cost = heroInfo:getCost(),
		littleStar = heroInfo:getLittleStar(),
		combat = heroInfo:getCombat(),
		maxStar = heroInfo:getMaxStar(),
		awakenLevel = heroInfo:getAwakenStar()
	}
end

function ChangeTeamModelMediator:initView()
	self._listPanel:removeAllChildren()

	for i = 1, #self._teamList do
		local team = self._teamList[i]

		if team:getMasterId() and #team:getHeroes() > 0 then
			local teamCell = self._teamClone:clone()

			self._listPanel:pushBackCustomItem(teamCell)
			self:teamCellSetup(teamCell, team)
		end
	end
end

function ChangeTeamModelMediator:refreshView()
	self:initData()
	self:initView()
end

function ChangeTeamModelMediator:teamCellSetup(cell, data)
	local oldName = data:getName()
	local editBox = convertTextFieldToEditBox(cell:getChildByFullName("TextField"), nil, MaskWordType.NAME)

	editBox:setText(data:getName())
	editBox:setName(data:getId())
	cell:getChildByFullName("nameBtn"):addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			local view = self:getInjector():getInstance("StageTeamView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
				tabType = data:getId()
			}))
		end
	end)
	editBox:onEvent(function(eventName, sender)
		if eventName == "began" then
			-- block empty
		elseif eventName == "ended" then
			-- block empty
		elseif eventName == "return" then
			local spaceCount = string.find(editBox:getText(), "%s")

			if spaceCount ~= nil then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("setting_tips1")
				}))
				editBox:setText(oldName)

				return
			end

			if editBox:getText() ~= oldName then
				local teaminfo = {
					name = editBox:getText(),
					teamId = sender:getName()
				}

				self._stageSystem:requestChangeTeamNameByCall(teaminfo, function(resCode, data)
					if DisposableObject:isDisposed(self) and DisposableObject:isDisposed(self:getView()) then
						return
					end

					if resCode == GS_SUCCESS then
						self:dispatch(ShowTipEvent({
							duration = 0.2,
							tip = Strings:get("Stage_UI2")
						}))
					else
						editBox:setText(oldName)
					end
				end, false)
			end
		elseif eventName == "changed" then
			-- block empty
		elseif eventName == "ForbiddenWord" then
			editBox:setText(oldName)
			self:getEventDispatcher():dispatchEvent(ShowTipEvent({
				tip = Strings:get("Common_Tip1")
			}))
		elseif eventName == "Exceed" then
			editBox:setText(oldName)
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Tips_WordNumber_Limit", {
					number = sender:getMaxLength()
				})
			}))
		end
	end)

	local masterRole = cell:getChildByName("Role")
	local masterData = self._masterSystem:getMasterById(data:getMasterId())
	local roleModel = masterData:getModel()
	local info = {
		frameId = "bustframe4_9",
		id = roleModel
	}
	local masterIcon = IconFactory:createRoleIconSpriteNew(info)

	masterIcon:setAnchorPoint(cc.p(0, 0))
	masterIcon:setPosition(cc.p(0, 0))
	masterRole:addChild(masterIcon)
	masterIcon:setScale(1.2)

	local node = cc.Node:create()

	node:setName("leadStage")

	local leadStageIcon = cell:getChildByName("leadStage")

	if not leadStageIcon then
		node:addTo(cell):posite(40, 26)
	end

	node:removeAllChildren()

	local id, lv = self._masterSystem:getMasterLeadStatgeLevel(data:getMasterId())
	local icon = IconFactory:createLeadStageIconHor(id, lv)

	if icon then
		icon:addTo(node)
	end

	for i = 1, 10 do
		local teamPet = cell:getChildByName("pet_" .. i)

		teamPet:removeAllChildren()

		local heroId = data:getHeroes()[i]

		if heroId and heroId ~= "" then
			local teamPetClone = self._teamPetClone:clone()

			teamPetClone:setScale(0.37)
			self:initTeamHero(teamPetClone, self:getHeroInfoById(heroId))
			teamPetClone:addTo(teamPet):center(teamPet:getContentSize())
			teamPetClone:offset(0, -5)
		else
			local emptyIcon = GameStyle:createEmptyIcon(true)

			emptyIcon:setScale(0.64)
			emptyIcon:addTo(teamPet):center(teamPet:getContentSize())
		end
	end

	cell:getChildByFullName("teamBtn"):addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:dispatch(Event:new(EVT_CHANGE_TEAM_BYMODE_SUCC, data))
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Activity_FastTeamTip")
			}))
			self:close()
		end
	end)
end

function ChangeTeamModelMediator:initTeamHero(node, info)
	assert(info ~= nil, "Hero is nil!")

	info.id = info.roleModel

	local weak = node:getChildByName("weak")
	local weakTop = node:getChildByName("weak")

	weak:removeAllChildren()
	weakTop:removeAllChildren()

	if info and info.awakenLevel and info.awakenLevel > 0 then
		local anim = cc.MovieClip:create("dikuang_yinghunxuanze")

		anim:addTo(weak):center(weak:getContentSize())
		anim:setScale(2)
		anim:offset(-5, 18)

		anim = cc.MovieClip:create("shangkuang_yinghunxuanze")

		anim:addTo(weakTop):center(weakTop:getContentSize())
		anim:setScale(2)
		anim:offset(-5, 18)
	end

	local heroImg = IconFactory:createRoleIconSpriteNew(info)

	heroImg:setScale(0.68)

	local heroPanel = node:getChildByName("hero")

	heroPanel:removeAllChildren()
	heroPanel:addChild(heroImg)
	heroImg:setPosition(heroPanel:getContentSize().width / 2, heroPanel:getContentSize().height / 2)

	local bg1 = node:getChildByName("bg1")
	local bg2 = node:getChildByName("bg2")

	bg1:loadTexture(GameStyle:getHeroRarityBg(info.rareity)[1])
	bg2:loadTexture(GameStyle:getHeroRarityBg(info.rareity)[2])
	bg1:removeAllChildren()
	bg2:removeAllChildren()

	if kHeroRarityBgAnim[info.rareity] then
		local anim = cc.MovieClip:create(kHeroRarityBgAnim[info.rareity])

		anim:addTo(bg1):center(bg1:getContentSize())

		if info.rareity <= 14 then
			anim:offset(-1, -29)
		else
			anim:offset(-3, 0)
		end

		if info.rareity >= 14 then
			local anim = cc.MovieClip:create("ssrlizichai_yingxiongxuanze")

			anim:addTo(bg2):center(bg2:getContentSize()):offset(5, -20)
		end
	else
		local sprite = ccui.ImageView:create(GameStyle:getHeroRarityBg(info.rareity)[1])

		sprite:addTo(bg1):center(bg1:getContentSize())
	end

	local rarity = node:getChildByFullName("rarityBg.rarity")
	local rarityAnim = IconFactory:getHeroRarityAnim(info.rareity)

	rarityAnim:addTo(rarity):posite(25, 15)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(info.type)
	local occupation = node:getChildByName("occupation")

	occupation:loadTexture(occupationImg)

	local level = node:getChildByName("level")

	level:setString(Strings:get("Strenghten_Text78", {
		level = info.level
	}))
end
