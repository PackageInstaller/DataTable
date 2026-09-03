-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterLeadStageMediator.lua

MasterLeadStageMediator = class("MasterLeadStageMediator", DmAreaViewMediator, _M)

local kBtnHandlers = {
	["main.Node_Bottom.leadStageBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickUpgrade"
	}
}
local changeColor = {
	cc.c3b(255, 223, 76),
	cc.c3b(159, 31, 248),
	cc.c3b(22, 126, 255),
	cc.c3b(0, 211, 119),
	cc.c3b(231, 0, 130),
	cc.c3b(0, 208, 227)
}
local subTreeSizeLimit = {
	{
		115,
		255
	},
	{
		130,
		265
	},
	{
		150,
		285
	},
	{
		185,
		385
	},
	{
		170,
		435
	},
	{
		50,
		240
	}
}
local bg_animName = {
	leadStage_scene_lan = "eff_zong_shenshu_lan",
	leadStage_scene_lv = "eff_zong_shenshu_lv",
	leadStage_scene_huang = "eff_zong_shenshu_huang",
	leadStage_scene_hong = "eff_zong_shenshu_hong",
	leadStage_scene_zi = "eff_zong_shenshu_zi",
	leadStage_scene_nvzhu = "eff_zong_shenshu_nvzhu"
}
local stage_animName = {
	["ico_leadstage_stage02.png"] = "eff_stage_2",
	["ico_leadstage_stage03.png"] = "eff_stage_3",
	["ico_leadstage_stage04.png"] = "eff_stage_4",
	["ico_leadstage_stage01.png"] = "eff_stage_1",
	["ico_leadstage_stage05.png"] = "eff_stage_5",
	["ico_leadstage_stage06.png"] = "eff_stage_6",
	["ico_leadstage_stage07.png"] = "eff_stage_7",
	["ico_leadstage_stage08.png"] = "eff_stage_8"
}
local animTime = 0.5
local progrSleepTime = 0.01
local bg_BasePath = "asset/scene/"
local changeHeight_top = 50
local changeTime_top = 0.1
local changeHeight_bottom = 500
local changeTime_bottom = 0.2
local mainTreeSize_0_height = 130
local mainTreeSize_3_height = 155
local mainTreeSize_5_height = 182
local mainTreeSize_all_height = 300

function MasterLeadStageMediator:initialize()
	super.initialize(self)
end

function MasterLeadStageMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function MasterLeadStageMediator:onRegister()
	super.onRegister(self)

	self._developSystem = self:getInjector():getInstance("DevelopSystem")
	self._masterSystem = self._developSystem:getMasterSystem()
	self._bagSystem = self._developSystem:getBagSystem()

	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
end

function MasterLeadStageMediator:refreshData(masterId)
	self._isBtnClicked = false

	if masterId then
		self._masterId = masterId
	end

	self._masterData = self._masterSystem:getMasterById(self._masterId)
	self._leadStageData = self._masterData:getLeadStageData()
	self._configInfo = self._leadStageData:getConfigInfo()
	self._leadStageLevel = self._leadStageData:getLeadStageLevel()
	self._useTreeAnim = false

	if self._masterSystem:getDoStageLvUpAnim() == true and self._leadStageLevel >= 1 then
		self._useTreeAnim = true

		if self._leadStageLevel == 1 then
			self._useTreeAnim = false
		end

		self._leadStageLevel = self._leadStageLevel - 1
	else
		self._masterSystem:setDoStageLvUpAnim(false)
	end

	self._levelUpAnimIndex = 0
	self._dolevelUpAnimType = 0
	self._doingLevelUpAnim = false
end

function MasterLeadStageMediator:refreshAllView()
	self:refreshView()
end

function MasterLeadStageMediator:setupView(parentMedi, data)
	self._parentMediator = parentMedi

	self:initNodes()
	self:initStageTouch()
	self:setupClickEnvs()
end

function MasterLeadStageMediator:refreshView()
	self:stopTimer()

	if self._skillTipNode then
		self._skillTipNode:removeFromParent(true)

		self._skillTipNode = nil
		self._skillShowWidget = nil
	end

	self:initBackground()
	self:initSkill()
	self:doStageLogic(true)
	self:doStageTreeLogic()
	self:refreshBtn()

	if self._masterSystem:getDoStageLvUpAnim() == true then
		self._masterSystem:setDoStageLvUpAnim(false)

		if self._useTreeAnim then
			delayCallByTime(1, function()
				self:onStageLevelUp()
			end)
		else
			self._useTreeAnim = false

			self:doFirstStageLevelShining()
		end
	end
end

function MasterLeadStageMediator:initNodes()
	self._main = self:getView():getChildByFullName("main")
	self._middleNode = self._main:getChildByFullName("middleNode")
	self._Image_Bg = self._main:getChildByFullName("middleNode.Image_Bg")
	self._leadStageBtn = self._main:getChildByFullName("Node_Bottom.leadStageBtn")
	self._leadStageBtnAnimNode = self._main:getChildByFullName("Node_Bottom.leadStageBtn.anim")
	self.animAwaken = cc.MovieClip:create("juexingrukou_juexingrukou")

	self.animAwaken:addTo(self._leadStageBtnAnimNode):offset(-320, 137)
	self.animAwaken:gotoAndPlay(0)
	self.animAwaken:setVisible(false)

	self._leadStageBtnBg = self._leadStageBtn:getChildByFullName("BG")
	self._treeNode = self._main:getChildByFullName("middleNode.treeNode")
	self._darkTreeNode = self._treeNode:getChildByFullName("darkTreeNode")
	self._lightTreeNode = self._treeNode:getChildByFullName("lightTreeNode")
	self._PanelLimitSize = {}

	for i = 1, 7 do
		local darkNode = self._darkTreeNode:getChildByFullName("darkNode_" .. i)
		local lightNode = self._lightTreeNode:getChildByFullName("lightNode_" .. i)
		local Panel_limit = lightNode:getChildByFullName("Panel_limit")
		local Image_0 = lightNode:getChildByFullName("Panel_limit.Image_0")

		self._PanelLimitSize[i] = {}
		self._PanelLimitSize[i][1] = Panel_limit:getContentSize()
		self._PanelLimitSize[i][2] = Image_0:getPositionX()
	end
end

function MasterLeadStageMediator:initStageTouch()
	for i = 1, 8 do
		local stageNode = self._main:getChildByFullName("middleNode.stageNode_" .. i)
		local touchPanel = stageNode:getChildByFullName("touchPanel")

		touchPanel:addTouchEventListener(function(sender, eventType)
			self:onClickStage(sender, eventType, i)
		end)
	end
end

function MasterLeadStageMediator:initBackground()
	local Background = ConfigReader:getDataByNameIdAndKey("MasterBase", self._masterId, "Background")

	if Background then
		self._Image_Bg:loadTexture(bg_BasePath .. Background .. ".jpg", ccui.TextureResType.localType)

		local Node_bg_anim = self._main:getChildByFullName("middleNode.Node_bg_anim")

		Node_bg_anim:removeAllChildren()

		local anim_name = bg_animName[Background] .. "_yuanjiebeijingeff"
		local anim_bg = cc.MovieClip:create(anim_name)

		anim_bg:addTo(Node_bg_anim)
	end
end

function MasterLeadStageMediator:initSkill()
	local allSkill = self._leadStageData:getConfigInfo()
	local showLeadStageLevel = self._leadStageLevel

	if showLeadStageLevel == 0 then
		showLeadStageLevel = 1
	end

	local stageSkills = allSkill[showLeadStageLevel].skills
	local desText = self._main:getChildByFullName("Node_Bottom.desText")

	desText:setString(Strings:get(self._configInfo[showLeadStageLevel].StageText))

	for index = 1, 4 do
		local skillId = stageSkills[index]
		local oneSkill = stageSkills[skillId]
		local skillNode = self._main:getChildByFullName("Node_Bottom.skillNode_" .. index)

		skillNode:removeAllChildren()

		local info = {
			scale = 0.9,
			id = skillId,
			isLock = self._leadStageLevel == 0 and true or oneSkill.state == MasterLeadStageSkillState.KLOCK
		}
		local newSkillNode = IconFactory:createMasterLeadStageSkillIcon(info, {}, function()
			local skillData = {}

			skillData.skillId = skillId
			skillData.masterData = self._masterData
			skillData.stageLevel = self._leadStageLevel
			skillData.mediator = self
			skillData.skillIndex = index

			self:showSkillTip(skillData, index)
		end)

		newSkillNode:setScale(0.6)
		newSkillNode:addTo(skillNode):posite(-30, -30)
	end
end

function MasterLeadStageMediator:showSkillTip(skillData, index)
	local skillNode = self._main:getChildByFullName("Node_Bottom.skillNode_" .. index)
	local parentView = self._parentMediator:getView()

	if not self._skillTipNode then
		self._skillTipNode = MasterLeadStageSkillTip:createWidgetNode()

		self._skillTipNode:setVisible(false)
		self._skillTipNode:addTo(parentView):posite(200, 85)

		self._skillShowWidget = self:autoManageObject(self:getInjector():injectInto(MasterLeadStageSkillTip:new(self._skillTipNode, skillData)))
	end

	local targetPos = skillNode:getParent():convertToWorldSpace(cc.p(skillNode:getPosition()))

	self._skillTipNode:setPositionX(parentView:convertToNodeSpace(targetPos).x + 50)
	self._skillShowWidget:refreshInfo(skillData)

	if self._skillTipNode:isVisible() then
		self._skillTipNode:setVisible(false)
	else
		self._skillTipNode:setVisible(true)
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end
end

function MasterLeadStageMediator:doStageLogic(refresh)
	for i = 1, 8 do
		local stageNode = self._main:getChildByFullName("middleNode.stageNode_" .. i)
		local Node_icon = stageNode:getChildByFullName("Node_icon")
		local Image_icon = stageNode:getChildByFullName("Image_icon")
		local nameText = stageNode:getChildByFullName("nameText")
		local imgLock = stageNode:getChildByFullName("img_lock")

		imgLock:setPosition(cc.p(0, 0))

		if i == 8 then
			imgLock:offset(11, -4)
		end

		imgLock:setScale(i == 8 and 1.05 or i == 1 and 0.85 or 0.58)
		imgLock:setVisible(false)

		if self._configInfo[i] then
			nameText:setString(Strings:get(self._configInfo[i].RomanNum) .. " " .. Strings:get(self._configInfo[i].StageName))

			if refresh then
				Node_icon:stopAllActions()
				Node_icon:removeAllChildren()
				Node_icon:setPosition(0, 0)
			end

			if i > self._leadStageLevel then
				Image_icon:setVisible(true)
				Image_icon:setGray(true)
				stageNode:setOpacity(127.5)
			else
				stageNode:setOpacity(255)
				Image_icon:setVisible(false)

				if Node_icon:getChildByTag(666) == nil then
					local anim_name = "eff_stage_" .. i .. "_yuanjietubiaoeff"

					if self._configInfo[i].Icon then
						anim_name = stage_animName[self._configInfo[i].Icon] .. "_yuanjietubiaoeff"
					end

					local anim = cc.MovieClip:create("eff_stage_" .. i .. "_yuanjietubiaoeff")

					anim:addTo(Node_icon)
					anim:setTag(666)

					if i == 1 then
						local move1 = cc.MoveBy:create(0.6666666666666666, cc.p(0, -5.5))
						local move2 = cc.MoveBy:create(1, cc.p(0, 5.5))
						local sequence = cc.Sequence:create(move1, move2)

						Node_icon:runAction(cc.RepeatForever:create(sequence))
					elseif i == 2 then
						local move1 = cc.MoveBy:create(0.6666666666666666, cc.p(0, 3))
						local move2 = cc.MoveBy:create(1, cc.p(0, -3))
						local sequence = cc.Sequence:create(move1, move2)

						Node_icon:runAction(cc.RepeatForever:create(sequence))
					elseif i == 3 then
						local move1 = cc.MoveBy:create(0.6666666666666666, cc.p(0, 5))
						local move2 = cc.MoveBy:create(1, cc.p(0, -5))
						local sequence = cc.Sequence:create(move1, move2)

						Node_icon:runAction(cc.RepeatForever:create(sequence))
					elseif i == 4 then
						local move1 = cc.MoveBy:create(0.6666666666666666, cc.p(0, -4.5))
						local move2 = cc.MoveBy:create(1, cc.p(0, 4.5))
						local sequence = cc.Sequence:create(move1, move2)

						Node_icon:runAction(cc.RepeatForever:create(sequence))
					elseif i == 5 then
						local move1 = cc.MoveBy:create(0.6666666666666666, cc.p(0, -3))
						local move2 = cc.MoveBy:create(1, cc.p(0, 3))
						local sequence = cc.Sequence:create(move1, move2)

						Node_icon:runAction(cc.RepeatForever:create(sequence))
					elseif i == 6 then
						local move1 = cc.MoveBy:create(0.6666666666666666, cc.p(0, -3))
						local move2 = cc.MoveBy:create(1, cc.p(0, 3))
						local sequence = cc.Sequence:create(move1, move2)

						Node_icon:runAction(cc.RepeatForever:create(sequence))
					elseif i == 7 then
						local move1 = cc.MoveBy:create(0.6666666666666666, cc.p(0, -6))
						local move2 = cc.MoveBy:create(1, cc.p(0, 6))
						local sequence = cc.Sequence:create(move1, move2)

						Node_icon:runAction(cc.RepeatForever:create(sequence))
					elseif i == 8 then
						local move1 = cc.MoveBy:create(0.6666666666666666, cc.p(0, 5))
						local move2 = cc.MoveBy:create(1, cc.p(0, -5))
						local sequence = cc.Sequence:create(move1, move2)

						Node_icon:runAction(cc.RepeatForever:create(sequence))
					end
				end
			end
		end
	end
end

function MasterLeadStageMediator:doStageTreeLogic()
	local treeColor_config = ConfigReader:getDataByNameIdAndKey("MasterBase", self._masterId, "TreeColor")
	local treeColor = cc.c3b(0, 211, 119)

	if treeColor_config and #treeColor_config == 3 then
		treeColor = cc.c3b(tonumber(treeColor_config[1]), tonumber(treeColor_config[2]), tonumber(treeColor_config[3]))
	end

	for i = 1, 7 do
		local darkNode = self._darkTreeNode:getChildByFullName("darkNode_" .. i)
		local lightNode = self._lightTreeNode:getChildByFullName("lightNode_" .. i)
		local Panel_limit = lightNode:getChildByFullName("Panel_limit")
		local Image_0 = lightNode:getChildByFullName("Panel_limit.Image_0")
		local Image_1 = lightNode:getChildByFullName("Panel_limit.Image_1")
		local Image_2 = lightNode:getChildByFullName("Panel_limit.Image_2")

		Image_0:setColor(treeColor)
		Image_1:setColor(treeColor)
		darkNode:setVisible(true)
		lightNode:setVisible(false)
		Image_0:setVisible(false)

		if i < self._leadStageLevel then
			darkNode:setVisible(false)
			lightNode:setVisible(true)

			if i == self._leadStageLevel - 1 then
				Panel_limit:setContentSize(self._PanelLimitSize[i][1])
				Image_0:setPositionX(self._PanelLimitSize[i][2])
				Image_1:setPositionX(self._PanelLimitSize[i][2])
				Image_2:setPositionX(self._PanelLimitSize[i][2])
				Image_0:setVisible(false)
				Image_1:setVisible(true)
			end
		end

		if i == 7 and self._leadStageLevel > 3 then
			lightNode:setVisible(true)
			Image_1:setVisible(false)

			if self._leadStageLevel == 4 or self._leadStageLevel == 5 then
				Panel_limit:setContentSize(cc.size(Panel_limit:getContentSize().width, mainTreeSize_3_height))
			elseif self._leadStageLevel == 6 or self._leadStageLevel == 7 then
				Panel_limit:setContentSize(cc.size(Panel_limit:getContentSize().width, mainTreeSize_5_height))
			else
				darkNode:setVisible(false)
				Image_1:setVisible(true)
				Panel_limit:setContentSize(cc.size(Panel_limit:getContentSize().width, mainTreeSize_all_height))
			end
		end
	end
end

function MasterLeadStageMediator:doFirstStageLevelShining()
	self._leadStageLevel = self._leadStageData:getLeadStageLevel()

	self:refreshBtn()

	local stageNode = self._main:getChildByFullName("middleNode.stageNode_1")
	local Node_icon = stageNode:getChildByFullName("Node_icon")
	local anim = cc.MovieClip:create("newactivate_yuanjietubiaoeff")

	anim:addTo(Node_icon)
	anim:setScale(0.6)
	self:doStageLogic(false)
	self:initSkill()
	AudioEngine:getInstance():playEffect("Se_Effect_Stage_Get", false)
	anim:addCallbackAtFrame(15, function()
		anim:stop()
		anim:removeFromParent()
		self:doStory()
	end)
end

function MasterLeadStageMediator:onStageLevelUp()
	self._masterData = self._masterSystem:getMasterById(self._masterId)
	self._leadStageData = self._masterData:getLeadStageData()
	self._configInfo = self._leadStageData:getConfigInfo()
	self._leadStageLevel = self._leadStageData:getLeadStageLevel()

	self:doingLevelUp()
	self:refreshBtn()
end

function MasterLeadStageMediator:doMainTreeLineAnimFirst(levelUpAnimIndex)
	local taget_height = 0
	local origin_height = mainTreeSize_0_height

	if levelUpAnimIndex == 3 then
		taget_height = mainTreeSize_3_height
	elseif levelUpAnimIndex == 5 then
		taget_height = mainTreeSize_5_height
		origin_height = mainTreeSize_3_height
	elseif levelUpAnimIndex == 7 then
		taget_height = mainTreeSize_all_height
		origin_height = mainTreeSize_5_height
	else
		return
	end

	local darkNode = self._darkTreeNode:getChildByFullName("darkNode_7")
	local lightNode = self._lightTreeNode:getChildByFullName("lightNode_7")
	local Panel_limit = lightNode:getChildByFullName("Panel_limit")
	local Image_0 = Panel_limit:getChildByFullName("Image_0")
	local Image_1 = Panel_limit:getChildByFullName("Image_1")

	Image_1:setVisible(false)
	Image_0:setVisible(true)

	local TargetSize = cc.size(Panel_limit:getContentSize().width, taget_height)

	Panel_limit:setContentSize(cc.size(TargetSize.width, origin_height))
	lightNode:setVisible(true)

	self._levelUpAnimIndex = levelUpAnimIndex

	if self._timer == nil then
		local p_size_height = mainTreeSize_all_height / (animTime / progrSleepTime)

		local function update()
			local Panel_limitSize = Panel_limit:getContentSize()
			local current_height = Panel_limitSize.height + p_size_height

			if current_height > TargetSize.height then
				current_height = TargetSize.height
			end

			Panel_limit:setContentSize(cc.size(Panel_limitSize.width, current_height))

			if current_height >= TargetSize.height then
				if self._levelUpAnimIndex == 3 or self._levelUpAnimIndex == 5 then
					self:stopTimer()
					self:doSubsidiaryTreeLineAnim(levelUpAnimIndex)
				else
					self:levelUpAnimOver(Panel_limit)
				end

				return
			end
		end

		self._timer = LuaScheduler:getInstance():schedule(update, progrSleepTime, true)
	end
end

function MasterLeadStageMediator:doSubsidiaryTreeLineAnim(levelUpAnimIndex)
	local darkNode = self._darkTreeNode:getChildByFullName("darkNode_" .. levelUpAnimIndex)
	local lightNode = self._lightTreeNode:getChildByFullName("lightNode_" .. levelUpAnimIndex)
	local Panel_limit = lightNode:getChildByFullName("Panel_limit")
	local Image_0 = Panel_limit:getChildByFullName("Image_0")
	local Image_1 = Panel_limit:getChildByFullName("Image_1")
	local Image_2 = Panel_limit:getChildByFullName("Image_2")
	local origin_width = 0
	local targetSize_width = Panel_limit:getContentSize().width
	local targetSize_height = Panel_limit:getContentSize().height

	if subTreeSizeLimit[levelUpAnimIndex] then
		origin_width = subTreeSizeLimit[levelUpAnimIndex][1]
		targetSize_width = subTreeSizeLimit[levelUpAnimIndex][2]
	end

	self._dolevelUpAnimType = (levelUpAnimIndex == 1 or levelUpAnimIndex == 5 or levelUpAnimIndex == 6) and 1 or 2

	Panel_limit:setContentSize(cc.size(origin_width, targetSize_height))

	if self._dolevelUpAnimType == 1 then
		Image_0:setPositionX(origin_width)
		Image_1:setPositionX(origin_width)
		Image_2:setPositionX(origin_width)
	end

	lightNode:setVisible(true)
	Image_1:setVisible(false)
	Image_0:setVisible(true)

	self._levelUpAnimIndex = levelUpAnimIndex

	if self._timer == nil then
		local p_size_width = targetSize_width / (animTime / progrSleepTime)

		local function update()
			if self._dolevelUpAnimType <= 0 then
				return
			end

			local Panel_limitSize = Panel_limit:getContentSize()
			local current_width = Panel_limitSize.width + p_size_width

			Panel_limit:setContentSize(cc.size(current_width, targetSize_height))

			if self._dolevelUpAnimType == 1 then
				Image_0:setPositionX(current_width)
				Image_1:setPositionX(current_width)
				Image_2:setPositionX(current_width)
			end

			if current_width >= targetSize_width then
				self:levelUpAnimOver(Panel_limit)

				return
			end
		end

		self._timer = LuaScheduler:getInstance():schedule(update, progrSleepTime, true)
	end
end

function MasterLeadStageMediator:doingLevelUp()
	local levelUpAnimIndex = self._leadStageLevel - 1

	if levelUpAnimIndex < 1 or levelUpAnimIndex > 7 then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Effect_Stage_Line", false)

	self._doingLevelUpAnim = true

	if levelUpAnimIndex == 3 or levelUpAnimIndex == 5 or levelUpAnimIndex == 7 then
		self:doMainTreeLineAnimFirst(levelUpAnimIndex)
	else
		self:doSubsidiaryTreeLineAnim(levelUpAnimIndex)
	end
end

function MasterLeadStageMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end

function MasterLeadStageMediator:levelUpAnimOver(Panel_limit)
	self:stopTimer()

	self._dolevelUpAnimType = 0

	if self._leadStageLevel < 0 or self._leadStageLevel > 8 then
		return
	end

	local Image_0 = Panel_limit:getChildByFullName("Image_0")
	local Image_1 = Panel_limit:getChildByFullName("Image_1")

	Image_0:setVisible(false)
	Image_1:setVisible(true)

	local stageNode = self._main:getChildByFullName("middleNode.stageNode_" .. self._leadStageLevel)
	local Node_icon = stageNode:getChildByFullName("Node_icon")
	local anim = cc.MovieClip:create("newactivate_yuanjietubiaoeff")

	anim:addTo(Node_icon)

	if self._leadStageLevel < 8 then
		anim:setScale(0.6)
	end

	self._doingLevelUpAnim = false

	self:doStageTreeLogic()
	self:doStageLogic(false)
	self:initSkill()
	AudioEngine:getInstance():playEffect("Se_Effect_Stage_Get", false)
	anim:addCallbackAtFrame(15, function()
		anim:stop()
		anim:removeFromParent()
		self:doStory()
	end)
end

function MasterLeadStageMediator:onClickUpgrade()
	if self._doingLevelUpAnim then
		return
	end

	if self._isBtnClicked then
		return
	end

	self._isBtnClicked = true

	local function callback()
		local stageData = self._masterData:getLeadStageData()
		local curLevel = stageData:getLeadStageLevel()
		local isMax = stageData:isMaxLevel()
		local detailConfig = stageData:getConfigInfo()

		if not isMax then
			local info = detailConfig[curLevel + 1]

			if info.LeadStageControl == 1 then
				curLevel = curLevel + 1
			end
		end

		AudioEngine:getInstance():playEffect("Se_Effect_Stage_Detail", false)
		self._developSystem:requstNotEnoughItem("LeadStage", CurrencyIdKind.KMasterStage_Exp)

		local view = self:getInjector():getInstance("MasterLeadStageDetailView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			stageNum = curLevel,
			masterId = self._masterId,
			anim = self._anim
		}))
	end

	self:runTransLateAction(callback)
end

function MasterLeadStageMediator:runTransLateAction(callback)
	local animNode = self._parentMediator:getAnimNode()

	self._anim = cc.MovieClip:create("eff_zhuanchang_yuanjiebeijingeff")

	local mc_bgPanel = self._anim:getChildByFullName("imgBg")

	for i = 1, 2 do
		local mc_img1 = mc_bgPanel:getChildByFullName("img_bg" .. i)
		local mc_bg = mc_img1:getChildByFullName("bg")
		local img1 = ccui.ImageView:create("asset/scene/leadStage_scene_xq.jpg")

		img1:addTo(mc_bg)
	end

	self._anim:gotoAndPlay(1)
	self._anim:setPlaySpeed(1.2)
	self._anim:addTo(animNode)
	self._anim:addCallbackAtFrame(10, function()
		if callback then
			callback()
		end
	end)
	self._anim:addEndCallback(function(cid, mc)
		mc:stop()
	end)
end

function MasterLeadStageMediator:runStartAction()
	return
end

function MasterLeadStageMediator:refreshBtn()
	local ret = not self._leadStageData:isMaxLevel()

	if ret then
		local rets = self._masterSystem:checkLeadStageCondition(self._masterId, self._leadStageLevel + 1)

		if table.indexof(rets, false) then
			ret = false
		end
	end

	if ret then
		local cost = self._leadStageData:getCost()

		for i = 1, #cost do
			local hasNum = self._bagSystem:getItemCount(cost[i].id)
			local needNum = cost[i].n

			if hasNum < needNum then
				ret = false

				break
			end
		end
	end

	self.animAwaken:setVisible(ret)
	self._leadStageBtnBg:setVisible(not ret)
end

function MasterLeadStageMediator:onClickStage(sender, eventType, index)
	assert(index > 0 and index < 9, "invalid id")

	if eventType == ccui.TouchEventType.ended then
		if self._doingLevelUpAnim then
			return
		end

		local tag = sender:getTag()
		local info = self._configInfo[index]

		if info.LeadStageControl == 0 then
			AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("LeadStage_LockTip", {
					stageName = Strings:get(info.StageName)
				})
			}))

			return
		end

		local function callback()
			if self._isBtnClicked then
				return
			end

			AudioEngine:getInstance():playEffect("Se_Effect_Stage_Detail", false)

			local view = self:getInjector():getInstance("MasterLeadStageDetailView")

			self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
				stageNum = index,
				masterId = self._masterId,
				anim = self._anim
			}))

			self._isBtnClicked = true
		end

		self:runTransLateAction(callback)
	end
end

function MasterLeadStageMediator:doStory()
	local outSelf = self

	local function callback()
		if DisposableObject:isDisposed(self) then
			return
		end

		if outSelf._leadStageLevel <= 0 then
			return
		end

		local storyLink = outSelf._configInfo[outSelf._leadStageLevel].StoryLink

		if storyLink then
			local storyDirector = outSelf:getInjector():getInstance(story.StoryDirector)
			local storyAgent = storyDirector:getStoryAgent()

			storyAgent:setSkipCheckSave(true)
			storyAgent:trigger(storyLink, nil, function()
				AudioEngine:getInstance():playBackgroundMusic("Mus_Protagonist_Stage")
			end)
		end
	end

	if DisposableObject:isDisposed(self) then
		return
	end

	if self._isBtnClicked then
		return
	end

	local view = self:getInjector():getInstance("MasterLeadStageAwakeView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		masterId = self._masterId,
		callback = callback
	}))
end

function MasterLeadStageMediator:runChangeViewAction()
	local parentView = self._parentMediator:getView()
	local callbackFunc = cc.CallFunc:create(function()
		self._middleNode:setPositionY(0)
		parentView:setVisible(true)
		parentView:setOpacity(255)
	end)
	local moveTop = cc.MoveBy:create(changeTime_top, cc.p(0, changeHeight_top))
	local moveDown = cc.MoveBy:create(changeTime_bottom, cc.p(0, -changeHeight_bottom))
	local fadeOut = cc.FadeOut:create(changeTime_bottom)
	local delay = cc.DelayTime:create(changeTime_top)
	local sequence1 = cc.Sequence:create(moveTop, moveDown)
	local sequence2 = cc.Sequence:create(delay, fadeOut, callbackFunc)

	self._middleNode:runAction(sequence1)
	parentView:runAction(sequence2)
end

function MasterLeadStageMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	if self._leadStageBtn then
		storyDirector:setClickEnv("MasterEmblemMediator.topemblemBg", self._leadStageBtn, function(sender, eventType)
			return
		end)
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		storyDirector:notifyWaiting("enter_MasterLeadStageMediator")
	end))

	self:getView():runAction(sequence)
end
