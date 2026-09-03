-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleRoleObject.lua

require("dm.battle.view.BattleBehaviorNode")
require("dm.battle.view.widget.BattleRoleTopBar")
require("dm.battle.view.widget.BattleRoleIconBar")
require("dm.battle.view.widget.BattleBubbleWidget")

local specId = ""
local BuffColor = {
	Negative = "Negative",
	Red = {
		o_r = 96
	},
	Green = {
		o_r = -30,
		o_g = 70
	},
	Black = {
		g = 0.3,
		b = 0.3,
		contrast = 20,
		r = 0.3
	},
	Yellow = {
		o_g = 70,
		contrast = -30,
		o_r = 240
	},
	Purple = {
		o_r = 90,
		contrast = -30,
		o_b = 160
	},
	Statue = {
		o_g = 64,
		saturation = -100,
		o_r = 64,
		o_b = 64
	},
	Translucent = {
		a = 0.5
	},
	Invisible = {
		a = 0
	}
}
local kGravity = 14.700000000000001
local kMeasuringScale = 90

RoleType = {
	Hero = 2,
	Master = 1
}

local LiveState = {
	Lived = 1,
	Dead = -1,
	Fleeing = -3,
	Remove = -2,
	Dying = 0
}
local kTopBarHeight = 15
local cjson = require("cjson.safe")

BattleRoleObject = class("BattleRoleObject", DisposableObject, _M)

BattleRoleObject:has("_id", {
	is = "r"
})
BattleRoleObject:has("_homePlace", {
	is = "rw"
})
BattleRoleObject:has("_isLeftTeam", {
	is = "rw"
})
BattleRoleObject:has("_heroType", {
	is = "r"
})
BattleRoleObject:has("_context", {
	is = "rw"
})
BattleRoleObject:has("_battleGround", {
	is = "r"
})
BattleRoleObject:has("_liveState", {
	is = "r"
})
BattleRoleObject:has("_dataModel", {
	is = "r"
})
BattleRoleObject:has("_headWidget", {
	is = "rw"
})
BattleRoleObject:has("_heroHeadWidget", {
	is = "rw"
})
BattleRoleObject:has("_equipHpWidget", {
	is = "rw"
})
BattleRoleObject:has("_masterWidget", {
	is = "rw"
})
BattleRoleObject:has("_actionTransform", {
	is = "rw"
})
BattleRoleObject:has("_actionTransformRevise", {
	is = "rw"
})
BattleRoleObject:has("_isTeamFlipped", {
	is = "rwb"
})
BattleRoleObject:has("_roleAnim", {
	is = "r"
})
BattleRoleObject:has("_roleType", {
	is = "w"
})

local ROLE_ANIM_TAG = 100
local ROLE_TOP_ZORDER = 10
local kRelPosWithHeight = 0
local kRoleScale = 0.65

function BattleRoleObject:initialize(id, dataModel, viewContext)
	super.initialize(self)

	self._id = id
	self._dataModel = dataModel
	self._roleType = dataModel:getRoleType()
	self._isLeftTeam = self:isLeft()
	self._actionTransform = {}
	self._actionTransformRevise = {}
	self._actionLoopMap = {}

	self:setupViewContext(viewContext)

	self._buffMap = {}
	self._flyLabels = {}
	self._activeTags = {}
	self._activateNum = 0
	self._filmedNum = 0
	self._skillStateTag = {}
	self._liveState = LiveState.Lived

	local modelId = tostring(dataModel:getModelId())
	local modelCfg = self._dataModel:getModelConfig()

	assert(modelCfg ~= nil, "Model with modelId: " .. modelId .. " not exists!")

	self._modelScale = modelCfg.Zoom or 1
	self._modelScale = self._modelScale * (dataModel:getModelScale() or 1)

	if dataModel:getIsBattleField() then
		self._modelScale = 1.5
	end

	self._root = cc.Node:create()

	self._root:setLocalZOrder(math.abs(dataModel:getCellId()))

	self._node = cc.Node:create()

	self._node:addTo(self._root)

	self._activeNode = cc.Node:create()

	self._activeNode:addTo(self._node)

	self._modelNode = cc.Node:create()

	self._activeNode:addChild(self._modelNode, 0)
	self:positRoleNode()

	self._effectNode = cc.Node:create()

	self._effectNode:addTo(self._activeNode, 101)

	self._backFlaNode = cc.Node:create()

	self._backFlaNode:addTo(self._node, -1)
	self._backFlaNode:setVisible(false)

	self._frontFlaNode = cc.Node:create()

	self._frontFlaNode:addTo(self._node, 20)
	self._frontFlaNode:setVisible(false)

	self._topFlaNode = cc.GroupedNode:create()

	self._topFlaNode:addTo(self._node)
	self._topFlaNode:setVisible(false)
	self._topFlaNode:setGlobalZOrder(10)

	self._bottomFlaNode = cc.GroupedNode:create()

	self._bottomFlaNode:addTo(self._node)
	self._bottomFlaNode:setVisible(false)
	self._bottomFlaNode:setGlobalZOrder(-10)

	self._backActiveFla = cc.Node:create()

	self._backActiveFla:addTo(self._activeNode, -1)
	self._backActiveFla:setVisible(false)

	self._frontActiveFla = cc.Node:create()

	self._frontActiveFla:addTo(self._activeNode, 20)
	self._frontActiveFla:setVisible(false)

	self._coverActiveFla = cc.Node:create()

	self._coverActiveFla:addTo(self._activeNode, 21)

	self._bubbleNode = cc.Node:create()

	self._bubbleNode:addTo(self._activeNode, 102):setName("bubble")

	self._topBarContainer = cc.Node:create()

	self._node:addChild(self._topBarContainer, 10)

	self._iconContainer = cc.Node:create()

	self._topBarContainer:addChild(self._iconContainer, 10)

	self._rtpkBubbleNode = cc.Node:create()

	self._rtpkBubbleNode:addTo(self._topBarContainer, 10):setName("rtpkBubbleNode")

	local topBar = self:autoManageObject(BattleRoleTopBar:new(self._topBarContainer, nil, self._isLeftTeam, viewContext))

	topBar:bindActor(self)

	self._topBar = topBar

	local iconBar = self:autoManageObject(BattleRoleIconBar:new(self._iconContainer, nil, viewContext))

	iconBar:bindActor(self)

	self._iconBar = iconBar

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(229, 54, 34, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 255, 255, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	self._professionalRestraintSupLab = cc.Label:createWithTTF(Strings:get("BATTLE_Restraint"), TTF_FONT_FZYH_R, 26)

	self._node:addChild(self._professionalRestraintSupLab, 10)
	self._professionalRestraintSupLab:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
	self._professionalRestraintSupLab:enableOutline(cc.c4b(99, 5, 5, 255), 2)
	self._professionalRestraintSupLab:setVisible(false)
	self:updateHpBarVisibility(false)
	self:updateRpBarVisibility(false)
	self:createHeroAnim()

	self._baseColorMatrix = self._roleAnim:getColorMatrix()
	self._baseColorTrans = self._roleAnim:getColorTransform()

	local forward = self._isLeftTeam and 1 or -1

	self:setForward(forward)

	self._animLoop = 0
	self._state = "stand"
	self._backDur = 80
	self._skillEffect = {}
	self._skillMovies = {}

	if self._context then
		self._context:addEventListener(EVT_Battle_Hp_Changed, self, self.onHpChanged)
		self._context:addEventListener(EVT_Battle_Rp_Changed, self, self.onRpChanged)
		self._context:addEventListener(EVT_BATTLE_SHOW_BUFF, self, self.showBuff)
		self._context:addEventListener(EVT_BATTLE_HIDE_BUFF, self, self.hideBuff)
		self._context:addEventListener(EVT_Battle_Shield_Changed, self, self.onShieldChanged)
	end
end

function BattleRoleObject:dispose()
	if self._root ~= nil then
		self._root:removeFromParent()

		self._root = nil
	end

	if self._animTask then
		self._animTask:stop()

		self._animTask = nil
	end

	if self._flyTask then
		self._flyTask:stop()

		self._flyTask = nil
	end

	if self._moveTask then
		self._moveTask:stop()

		self._moveTask = nil
	end

	if self._groundMaskTask then
		self._groundMaskTask:stop()

		self._groundMaskTask = nil
	end

	if self._shiftPosTask then
		self._shiftPosTask:stop()

		self._shiftPosTask = nil
	end

	if self._context then
		self._context:removeEventListener(EVT_Battle_Hp_Changed, self, self.onHpChanged)
		self._context:removeEventListener(EVT_Battle_Shield_Changed, self, self.onShieldChanged)
		self._context:removeEventListener(EVT_Battle_Rp_Changed, self, self.onRpChanged)
		self._context:removeEventListener(EVT_BATTLE_SHOW_BUFF, self, self.showBuff)
		self._context:removeEventListener(EVT_BATTLE_HIDE_BUFF, self, self.hideBuff)
	end

	if self._buffIconEntry then
		self._buffIconEntry:stop()

		self._buffIconEntry = nil
	end

	self._dataModel:dispose()
	super.dispose(self)
end

function BattleRoleObject:isLive()
	return self._liveState == LiveState.Lived
end

function BattleRoleObject:isLeft()
	return self._dataModel:getCellId() > 0
end

function BattleRoleObject:isIdleState()
	return self._state == "stand" or self._state == "charge"
end

function BattleRoleObject:getStaticModelRes()
	local res = ""
	local model = self._dataModel:getModelConfig().Model

	res = "asset/heros/" .. model .. "/portraitpic_" .. model .. ".png"

	return (not cc.FileUtils:getInstance():isFileExist("asset/heros/" .. model .. "/portraitpic_" .. model .. ".png") or nil) and "asset/master/" .. model .. "/battle_" .. model .. ".png"
end

function BattleRoleObject:getHeightOffset()
	return kRelPosWithHeight
end

function BattleRoleObject:setupViewContext(viewContext)
	if self._context then
		return
	end

	self._context = viewContext
	self._unitManager = viewContext:getValue("BattleUnitManager")
	self._battleGround = viewContext:getValue("BattleGroundLayer")
	self._skeletonAnimGroup = viewContext:getValue("SkeletonAnimGroup")
end

function BattleRoleObject:setBattleGround(battleGround)
	self._battleGround = battleGround
end

function BattleRoleObject:setListener(listener)
	self._listener = listener
end

function BattleRoleObject:getView()
	return self._root
end

function BattleRoleObject:getRoleState()
	return self._state or "stand"
end

function BattleRoleObject:isInHomePlace()
	return self:getRelPosition().x == self:getHomePlace().x and self:getRelPosition().y == self:getHomePlace().y
end

function BattleRoleObject:normalized2Real(pos)
	local perspectiveTool = self._battleGround:getPerspectiveTool()
	local x, y = perspectiveTool:norm2view(pos.x, pos.y)

	return cc.p(x, y)
end

function BattleRoleObject:getRelPosition()
	if self._relPosition == nil then
		return {
			x = 0,
			y = 0
		}
	else
		return {
			x = self._relPosition.x,
			y = self._relPosition.y
		}
	end
end

function BattleRoleObject:setRelPosition(relPos, extraZ, height)
	assert(relPos ~= nil)

	self._relPosition = cc.p(relPos.x, relPos.y)

	if self._battleGround ~= nil then
		self._battleGround:setRelPosition(self:getView(), relPos, extraZ, height)
	end
end

function BattleRoleObject:setForward(forward)
	self._node:setScaleX(forward)

	self._forward = forward

	self._topBar:getView():setScaleX(forward)
	self._bubbleNode:setScaleX(forward)
	self._professionalRestraintSupLab:setScaleX(forward)
end

function BattleRoleObject:getForward()
	return self._forward
end

function BattleRoleObject:getScale()
	local scale = self._modelNode:getScaleX()

	return math.abs(scale)
end

function BattleRoleObject:positRoleNode()
	if self._modelNode ~= nil then
		self._modelNode:setPosition(0, 0)
	end
end

function BattleRoleObject:getModelWidth()
	local modelCfg = self._dataModel:getModelConfig()

	return math.abs(modelCfg.Width * kRoleScale * self._modelScale)
end

function BattleRoleObject:getModelHeight()
	local modelCfg = self._dataModel:getModelConfig()

	return modelCfg.Height * kRoleScale * self._modelScale
end

function BattleRoleObject:setLookat(offsetX)
	if self._isLeftTeam then
		self:setForward(offsetX < 0 and -1 or 1)
	else
		self:setForward(offsetX < 0 and 1 or -1)
	end
end

function BattleRoleObject:stopMoving()
	if self._moveTask ~= nil then
		self._moveTask:stop()

		self._moveTask = nil
		self._gobackDirty = false
	end
end

function BattleRoleObject:cancelThrown()
	if self._flyTask then
		self._flyTask:stop()

		self._flyTask = nil
		self._velocity = nil
		self._displacement = nil
		self._frameLabel = nil

		self._roleAnim:resumeAnimation()
		self._activeNode:setPosition(0, 0)
	end
end

function BattleRoleObject:updateHpBarVisibility(isVisible, force)
	if self._roleAnim and not self._roleAnim:isVisible() then
		return
	end

	local hpShow = tonumber(self._context:getValue("ShowHpMode"))
	local visibleSta = true

	if force then
		visibleSta = isVisible
	elseif hpShow == BattleHp_ShowType.Show then
		visibleSta = true
	elseif hpShow == BattleHp_ShowType.Hide then
		visibleSta = false
	elseif hpShow == BattleHp_ShowType.Simple then
		visibleSta = isVisible
	end

	self._topBarVisibleSta = isVisible
	self._topBarVisibleForceSta = force

	self._topBar:setHpVisible(visibleSta)
	self._iconContainer:setVisible(visibleSta)
end

function BattleRoleObject:updateFanBar(prgress)
	self._topBar:updateFanProgress(prgress)
end

function BattleRoleObject:isHpBarVisible()
	return self._topBar:isHpBarVisible()
end

function BattleRoleObject:updateRpBarVisibility(isVisible, force)
	local hpShow = tonumber(self._context:getValue("ShowHpMode"))
	local visibleSta = true

	if force then
		visibleSta = isVisible
	elseif hpShow == BattleHp_ShowType.Show then
		visibleSta = true
	elseif hpShow == BattleHp_ShowType.Hide then
		visibleSta = false
	elseif hpShow == BattleHp_ShowType.Simple then
		visibleSta = isVisible
	end

	self._topBar:setRpVisible(visibleSta)
end

function BattleRoleObject:isRpBarVisible()
	return self._topBar:isRpBarVisible()
end

function BattleRoleObject:showBuff()
	self._iconBar:stopShowTask()
	self._topBar:stopHpTask()
	self._topBar:stopRpTask()
	self:updateHpBarVisibility(true, true)
	self:updateRpBarVisibility(true, true)
end

function BattleRoleObject:hideBuff()
	self._iconBar:stopShowTask()
	self._topBar:stopHpTask()
	self._topBar:stopRpTask()
	self:updateHpBarVisibility(false, true)
	self:updateRpBarVisibility(false, true)
end

function BattleRoleObject:createHeroAnim()
	local child = self._modelNode:getChildByTag(ROLE_ANIM_TAG)

	if child then
		self._modelNode:removeChild(child, true)
	end

	local modelCfg = self._dataModel:getModelConfig()
	local animName = modelCfg.Model
	local pre = "asset/anim/"
	local jsonFile = pre .. animName .. ".skel"

	if not cc.FileUtils:getInstance():isFileExist(jsonFile) then
		jsonFile = self:createDefaultModel()
	end

	local roleAnim = sp.SkeletonAnimation:create(jsonFile)

	roleAnim:setSkeletonAnimationGroup(self._skeletonAnimGroup)
	self._modelNode:addChild(roleAnim, 0, ROLE_ANIM_TAG)

	self._roleAnim = roleAnim

	self:watchAnimAction()
	roleAnim:registerSpineEventHandler(handler(self, self.spineHandler), sp.EventType.ANIMATION_COMPLETE)
	roleAnim:registerSpineEventHandler(handler(self, self.spineHandler), sp.EventType.ANIMATION_EVENT)

	if self._roleType == RoleType.Master then
		self:switchState("stand", {
			loop = -1
		}, false, self.animCallback)
	else
		self:switchState("debut", {
			loop = -1
		}, false, self.animCallback)
	end

	local hpPercent = self._dataModel:getHp() / self._dataModel:getMaxHp() * 100

	self._topBar:setHp(hpPercent)

	local mpPercent = self:getShowRpNum(self._dataModel:getRp()) / self._dataModel:getMaxRp() * 100

	self._topBar:setRp(mpPercent)
	self._topBarContainer:setPosition(cc.p(0, self:getModelHeight() + kTopBarHeight))

	if self._roleType == RoleType.Master then
		self._professionalRestraintSupLab:setPosition(cc.p(0, self._topBarContainer:getPositionY() + kTopBarHeight + 20))
	else
		self._professionalRestraintSupLab:setPosition(cc.p(0, self._topBarContainer:getPositionY() + kTopBarHeight + 10))
	end

	if self._dataModel:getIsBattleField() then
		self._modelScale = 1.5

		roleAnim:setVisible(false)
		self._topBarContainer:setVisible(false)
		self._topBar:getView():setVisible(false)

		function self._topBarContainer.setVisible()
			return
		end

		function roleAnim.setVisible()
			return
		end

		self._topBar:getView().setVisible = function()
			return
		end
	end

	roleAnim:setScale(kRoleScale * self._modelScale)
end

function BattleRoleObject:transform()
	self:setBusyState(false)
	self:cancelThrown()
	self:setRelPosition(self._homePlace)

	self._modelScale = self._dataModel:getModelConfig().Zoom or 1

	self:createHeroAnim()
	self._roleAnim:setColorTransform(self._baseColorTrans)
	self:switchState("squat", {
		loop = 1
	})
end

function BattleRoleObject:doAction(actionName, record)
	if self._liveState == LiveState.Dead or self._liveState == LiveState.Remove then
		return
	end

	local processors = {}

	local function runCmd(cmd, params)
		local func = processors[cmd]

		if func ~= nil then
			func(cmd, params)
		else
			assert(false, cmd .. "can't be dealed")
		end
	end

	function processors.Hurt(cmd, args)
		assert(args ~= nil)

		local actId = args.act
		local final = args.final

		if not args.deadly then
			if args.deadly and self._liveState == LiveState.Lived then
				-- block empty
			end

			if args.raw == 0 then
				return
			end

			if args.deadly and false then
				local modelCfg = self._dataModel:getModelConfig()
				local mainMediator = self._context:getValue("BattleMainMediator")
				local soundName = modelCfg.DeathVoice

				if soundName ~= "" and soundName then
					mainMediator:playDieEffect(soundName)
				end
			end

			if final then
				local context = self._context

				context:setValue("FinalHit", true)
			end

			local block = args.block

			if block then
				local blockAnim = self._frontActiveFla:getChildByName("BlockAnim")

				if blockAnim then
					blockAnim:stop()
					blockAnim:removeFromParent(true)
				end

				blockAnim = self:addActiveEffect("gedang_bufftexiao", false, cc.p(0.5, 0.5), "front", 1, function(cid, mc)
					mc:removeFromParent(true)
				end)

				blockAnim:setName("BlockAnim")
				self._dataModel:addBlockInfo(actId)
			end

			self._topBar:shine()

			if self._headWidget then
				self._headWidget:shake(self._context)
			end
		end
	end

	function processors.Reflected(cmd, args)
		assert(args ~= nil)
	end

	function processors.Cured(cmd, args)
		local rawDamage = args.raw

		self:addHealth(rawDamage)
	end

	function processors.Absorb(cmd, args)
		local rawDamage = args.raw

		self:addHealth(rawDamage, {
			absorb = true
		})
	end

	function processors.Die(cmd, args)
		self._context:dispatch(Event:new(EVT_Battle_UnitDie, {
			id = self._id
		}))

		self._liveState = LiveState.Dying

		self:tryDie()
	end

	function processors.Kick(cmd, args)
		self._liveState = LiveState.Dead

		self:kick()
	end

	function processors.Clear(cmd, args)
		self:goBack()
	end

	function processors.ThrownKick(cmd, args)
		self._liveState = LiveState.Dead

		self:thrownKick()
	end

	runCmd(actionName, record)
end

function BattleRoleObject:addBuff(args)
	local display = args.disp

	if display == nil or display == "" then
		return
	end

	local buffModel = ConfigReader:getRecordById("BuffModel", display)

	if not buffModel then
		return
	end

	if not buffModel.Priority then
		local priorityValue = 0

		if not buffModel.Type then
			local priorityGroup = "@Default"

			if not self._buffMap[priorityGroup] then
				local groupMap = {}

				groupMap[display] = groupMap[display] or {}
				self._buffMap[priorityGroup] = groupMap

				local buffValue = groupMap[display]

				buffValue.count = (buffValue.count or 0) + 1

				local isFixPos = buffModel.Id == "Protecto" or buffModel.Id == "LeadStage_SenLing" or buffModel.Id == "LeadStage_SenLing_Start"
				local fixOrder = {
					Protecto = 1,
					LeadStage_SenLing = 0,
					LeadStage_SenLing_Start = 0
				}

				if buffValue.count <= 1 or buffValue.displayNodes == nil or #buffValue.displayNodes == 0 then
					if buffModel.Effect and buffModel.Effect ~= "" then
						buffValue.loopMode = buffModel.Loop
						buffValue.priority = priorityValue
						buffValue.displayNodes = {}

						local offsetX = buffModel.HorizontalPos

						offsetX = offsetX and (self._isLeftTeam and offsetX or 0 - offsetX)

						local function addEffect(anim, layer)
							return self:addActiveEffect(anim, buffValue.loopMode == 1, cc.p(offsetX or 0.5, buffModel.EffectPos), layer, 1, function(cid, mc)
								if buffValue.loopMode == 0 then
									table.removevalues(buffValue.displayNodes, mc)
									mc:removeFromParent()
								end
							end, isFixPos, fixOrder[buffModel.Id])
						end

						local displayNode = addEffect(buffModel.Effect, (buffModel.zOrder and buffModel.zOrder <= 0 or nil) and "back")

						displayNode:setVisible(false)

						buffValue.displayNodes[#buffValue.displayNodes + 1] = displayNode
					end

					if buffModel.Color and buffModel.Color ~= "" then
						buffValue.color = buffModel.Color
						self._filmed = buffModel.Color == BuffColor.Negative

						self:refreshColor()
					end
				end

				if buffModel.DescWord and buffModel.DescWord ~= "" then
					self:flyImage(buffModel.DescWord)
				end

				self:refreshBuffEffect()

				if buffModel.Icon and buffModel.Icon ~= "" then
					self._iconBar:addBuffIcon(args.buffId, buffModel.Icon, args.dur)
				end
			end
		end
	end
end

function BattleRoleObject:removeBuff(args)
	local display = args and args.disp

	if display == nil or display == "" then
		return
	end

	for key, groupMap in pairs(self._buffMap) do
		for disp, buffValue in pairs(groupMap) do
			if disp == display then
				buffValue.count = math.max(buffValue.count - 1, 0)

				if buffValue.count == 0 then
					if buffValue.displayNodes then
						for i, displayNode in ipairs(buffValue.displayNodes) do
							displayNode:stop()
							displayNode:removeFromParent(true)
						end
					end

					groupMap[display] = nil
				end
			end
		end
	end

	self._filmed = false

	self:refreshColor()
	self:refreshBuffEffect()

	local buffModel = ConfigReader:getRecordById("BuffModel", display)

	if not buffModel then
		return
	end

	if buffModel.Icon and buffModel.Icon ~= "" then
		self._iconBar:removeIcon(args.buffId)
	end
end

function BattleRoleObject:cleanBuff()
	for key, groupMap in pairs(self._buffMap) do
		for disp, buffValue in pairs(groupMap) do
			if buffValue.displayNodes then
				for i, displayNode in ipairs(buffValue.displayNodes) do
					displayNode:stop()
					displayNode:removeFromParent(true)
				end
			end

			groupMap[disp] = nil
		end

		self._buffMap[key] = nil
	end
end

function BattleRoleObject:tickBuff(args)
	local display = args.disp

	if display == nil or display == "" then
		return
	end

	local buffModel = ConfigReader:getRecordById("BuffModel", display)

	if not buffModel then
		return
	end

	if buffModel.Icon and buffModel.Icon ~= "" then
		self._iconBar:tickBuff(args.buffId, args.dur)
	end

	if buffModel.Tick and buffModel.Tick ~= "" then
		self._tickMap = self._tickMap or {}
		self._tickMap[display] = self._tickMap[display] or {}

		local buffValue = self._tickMap[display]

		buffValue.count = (buffValue.count or 0) + 1

		if buffValue.count > 1 then
			return
		end

		local displayNode = cc.MovieClip:create(buffModel.Tick, "BattleMCGroup")

		displayNode:setPositionY(self:getModelHeight() * buffModel.TickPos)
		displayNode:addTo(self._effectNode)

		buffValue.displayNode = displayNode

		displayNode:addEndCallback(function(cid, mc)
			mc:stop()
			mc:removeFromParent(true)

			buffValue.count = 0
			buffValue.displayNode = nil
		end)
	end
end

function BattleRoleObject:stackBuff(args)
	local display = args.disp

	if display == nil or display == "" then
		return
	end

	local buffModel = ConfigReader:getRecordById("BuffModel", display)

	if not buffModel then
		return
	end

	if buffModel.Icon and buffModel.Icon ~= "" then
		self._iconBar:stackBuff(args.buffId, args.dur, args.times)
	end

	local loopMode = buffModel.Loop

	if not loopMode or loopMode ~= 1 then
		self:addBuff(args)
	end
end

function BattleRoleObject:refreshBuffEffect()
	for key, grounMap in pairs(self._buffMap) do
		local por = 65535

		for display, buffValue in pairs(grounMap) do
			por = math.min(buffValue.priority or 0, por)

			local displayNodes = buffValue.displayNodes

			if displayNodes then
				for _, displayNode in ipairs(displayNodes) do
					displayNode:setVisible(false)
				end
			end
		end

		for display, buffValue in pairs(grounMap) do
			if buffValue.priority == por then
				local displayNodes = buffValue.displayNodes

				if displayNodes then
					for _, displayNode in ipairs(displayNodes) do
						displayNode:setVisible(true)
					end
				end
			end
		end
	end
end

function BattleRoleObject:refreshColor()
	self:colorReset()

	if self._filmed then
		self:colorFilm(-80, 10)

		return
	end

	for key, grounMap in pairs(self._buffMap) do
		local por = 65535

		for display, buffValue in pairs(grounMap) do
			if not buffValue.priority then
				local color = buffValue.color

				if color and buffValue.priority < por then
					por = buffValue.priority

					local args = BuffColor[color]

					self:colorDye(args)
				end
			end
		end
	end
end

function BattleRoleObject:colorFilm(saturation, contrast)
	local node = self._roleAnim

	node:setSaturation(saturation or -100)
	node:setContrast(contrast or 0)

	local colorMatrix = node:getColorMatrix()
	local tran = colorMatrix.transform
	local off = colorMatrix.offsets

	tran[1] = -tran[1]
	tran[2] = -tran[2]
	tran[3] = -tran[3]
	tran[5] = -tran[5]
	tran[6] = -tran[6]
	tran[7] = -tran[7]
	tran[9] = -tran[9]
	tran[10] = -tran[10]
	tran[11] = -tran[11]
	off.x = 255
	off.y = 255
	off.z = 255

	node:setColorMatrix(colorMatrix)
end

function BattleRoleObject:colorDye(args)
	local trans = {}

	table.deepcopy(self._baseColorTrans, trans)

	local mults, offsets = trans.mults, trans.offsets

	self._roleAnim:setSaturation(args.saturation or 0)
	self._roleAnim:setContrast(args.contrast or 0)
	self._roleAnim:setColorTransform(ColorTransform(args.r or mults.x, args.g or mults.y, args.b or mults.z, args.a or mults.w, args.o_r or offsets.x, args.o_g or offsets.y, args.o_b or offsets.z, args.o_a or offsets.w))
end

function BattleRoleObject:colorReset()
	if self._hsvChange then
		return
	end

	self._roleAnim:setSaturation(0)
	self._roleAnim:setColorMatrix(self._baseColorMatrix)
	self._roleAnim:setColorTransform(self._baseColorTrans)
end

function BattleRoleObject:addActiveEffect(mcFile, loop, dot, layer, zOrder, callback, isFixPos, FixZorder)
	if not mcFile then
		return
	end

	layer = layer or "front"
	dot = dot or {
		x = 0.5,
		y = 0.5
	}
	dot.x = dot.x or 0.5
	dot.y = dot.y or 0.5

	local anim = cc.MovieClip:create(mcFile, "BattleMCGroup")

	assert(anim, "MovieClip :" .. mcFile .. " not exists!")
	anim:addEndCallback(function(cid, mc)
		if loop ~= true then
			mc:stop()

			if callback then
				callback(cid, mc)
			end
		end
	end)

	local point = cc.p(self:getModelWidth() * dot.x - self:getModelWidth() * 0.5, self:getModelHeight() * dot.y)
	local var_63_0

	if layer == "cover" then
		var_63_0 = self._coverActiveFla

		if not self._coverActiveFla then
			if layer == "front" then
				var_63_0 = self._frontActiveFla or self._backActiveFla
			end
		end
	end

	anim:addTo(var_63_0)
	anim:setLocalZOrder((layer == "front" or layer == "cover") and zOrder or -zOrder)
	anim:setPosition(point)

	if isFixPos then
		local w_p = anim:getParent():convertToWorldSpace(point)
		local pos_h = self:getHomePlace()
		local pos_r = {
			x = pos_h.x + dot.x * 0.4,
			y = pos_h.y + 0.3333333333333333 * dot.y
		}

		self._battleGround:setRelPosition(anim, pos_r, 100, 100)
		anim:setScale(1)

		if FixZorder and FixZorder <= 0 then
			anim:changeParent(self._battleGround:getCellLayer())
		else
			anim:changeParent(self._battleGround:getGroundLayer())
		end
	end

	return anim
end

function BattleRoleObject:watchAnimAction()
	local function isDagunFinalAnim(animName)
		return animName == "win" or animName == "win_2" or animName == "win_3" or animName == "win_4" or animName == "die_5" or animName == "die_6" or animName == "die_7" or animName == "die_8"
	end

	local function adjustWinOrLoseZorder(animName)
		if isDagunFinalAnim(animName) and self._dataModel:getModelId() == "Model_LFKLFTe_DGun" then
			self:setDisplayZorder(1000)
		end
	end

	local playAnimation = self._roleAnim.playAnimation

	function self._roleAnim.playAnimation(anim, frameIndex, animName, isloop)
		if self._actionTransform[animName] then
			animName = self._actionTransform[animName]
		end

		adjustWinOrLoseZorder(animName)

		if self._actionLoopMap[animName] ~= nil then
			isloop = self._actionLoopMap[animName]

			local totalFrame = anim:getAnimationFrames(animName)

			anim:playAnimationInFrameIndex(0, animName, totalFrame - 2, false)

			return
		end

		playAnimation(anim, frameIndex, animName, isloop)
	end

	local setLocalZOrder = self:getView().setLocalZOrder

	self:getView().setLocalZOrder = function(target, zorder)
		if self._specialZorder then
			return
		end

		setLocalZOrder(target, zorder)
	end
end

function BattleRoleObject:addActiveNode(node, dot, layer, zOrder)
	layer = layer or "front"
	dot = dot or {
		x = 0.5,
		y = 0.5
	}
	dot.x = dot.x or 0.5
	dot.y = dot.y or 0.5

	local point = cc.p(self:getModelWidth() * dot.x - self:getModelWidth() * 0.5, self:getModelHeight() * dot.y)
	local var_70_0

	if layer == "cover" then
		var_70_0 = self._coverActiveFla

		if not self._coverActiveFla then
			if layer == "front" then
				var_70_0 = self._frontActiveFla or self._backActiveFla
			end
		end
	end

	node:addTo(var_70_0)
	node:setLocalZOrder((layer == "front" or layer == "cover") and zOrder or -zOrder)
	node:setPosition(point)
end

function BattleRoleObject:flyImage(path)
	local label = ccui.ImageView:create()

	label:loadTexture(path, ccui.TextureResType.plistType)

	local pos = cc.p(0, self:getModelHeight())

	pos = cc.pAdd(pos, cc.p(self:getView():getPosition()))

	local anim = cc.MovieClip:create("dhdh_diaoxue", "BattleMCGroup")
	local textNode = anim:getChildByName("text")

	label:addTo(textNode)

	if not self._flyImages then
		local flyImages = {}

		for i, mc in ipairs(self._flyImages) do
			mc:setLocalZOrder(i + 100)
			mc:setPositionY(mc:getPositionY() + 30)
		end

		self._flyImages[#self._flyImages + 1] = anim

		self._battleGround:addEffectNode(anim, pos, function(mc)
			local index = table.indexof(flyImages, mc)

			if index then
				table.remove(flyImages, index)
			end
		end)
		anim:setLocalZOrder(#self._flyImages + 100)

		self._flyImages = self._flyImages
	end
end

function BattleRoleObject:reduceHealth(raw, params)
	local label = self:createLabel(raw, params)

	self:flyLabel(label)
end

function BattleRoleObject:addHealth(raw, params)
	local curedAnim = self._frontActiveFla:getChildByName("CuredAnim")

	if curedAnim then
		curedAnim:stop()
		curedAnim:removeFromParent(true)
	end

	curedAnim = self:addActiveEffect("zhiliao_zhandoubuff", false, cc.p(0.5, 0.5), "front", 1, function(cid, mc)
		mc:removeFromParent(true)
	end)

	curedAnim:setName("CuredAnim")

	local label = self:createLabel(raw, {
		type = "cure",
		absorb = params and params.absorb
	})

	self:flyLabel(label)
end

local fntTable = {
	shield = "asset/font/zd_xishou.fnt",
	block = "asset/font/zd_diaoxue.fnt",
	damage = "asset/font/zd_diaoxue.fnt",
	cure = "asset/font/zd_huixue.fnt",
	reflect = "asset/font/zd_diaoxue.fnt",
	sub = "asset/font/zd_kz.fnt",
	poison = "asset/font/zd_zd.fnt",
	burning = "asset/font/zd_zs.fnt",
	crit = "asset/font/zd_baoji.fnt"
}
local labelTable = {
	shield = "zd_xs_word.png",
	block = "zd_gd_word.png",
	poison = "zd_zd_icon.png",
	immune = "zd_my_word.png",
	reflect = "zd_fs_word.png",
	burning = "zd_zs_icon.png",
	sub = "zd_kz_word.png",
	crit = "zd_bj_word.png"
}
local offsetYTable = {
	poison = 40
}

function BattleRoleObject:createLabel(raw, params)
	local labelType = params.type
	local fntFile = fntTable[labelType]
	local labelFile = labelTable[labelType]

	if not offsetYTable[labelType] then
		local offsetY = 0

		if not fntFile and params.type ~= "" then
			fntFile = fntTable.damage
		end

		if labelType == "damage" then
			if params.sub then
				fntFile = fntTable.sub
				labelFile = labelTable.sub
			end
		elseif labelType == "block" and params.sub then
			fntFile = fntTable.sub
		end

		local animFile = "szb_shuzi"
		local textNodeName = "text"
		local numscale = 1
		local offsetX = 100

		if params.type == "cure" and not params.absorb then
			animFile = "sz_shuzi"
			textNodeName = "text"
			numscale = 0.5
			offsetX = 0
		elseif self:isLeft() then
			animFile = "szbb_shuzi"
			textNodeName = "text"
			numscale = 1
			offsetX = 150
		end

		local anim = cc.MovieClip:create(animFile, "BattleMCGroup")

		anim:addEndCallback(function(cid, mc)
			mc:stop()
			mc:removeFromParent(true)
		end)
		anim:setPositionY(self:getModelHeight() + 10)

		local numText = tostring(raw)

		for i = 1, math.min(#numText, 7) do
			ccui.TextBMFont:create(string.sub(numText, i, i), fntFile):addTo(anim:getChildByFullName("num" .. i)):setScale(numscale)
			anim:offset(-10)
		end

		if labelFile then
			local sp = cc.Sprite:createWithSpriteFrameName(labelFile)
			local baseNode = anim:getChildByFullName(textNodeName)

			if sp and baseNode then
				sp:addTo(baseNode)
			end
		else
			anim:offset(-40)
		end

		anim:offset(offsetX, 50 + offsetY)
		anim:play()

		return anim
	end
end

function BattleRoleObject:flyLabel(node)
	local pos = cc.p(node:getPosition())

	pos = cc.pAdd(pos, cc.p(self:getView():getPosition()))

	self._battleGround:addEffevtive(node, pos)
	self._topBar:scheduleShowHp()
end

function BattleRoleObject:syncMainViewMaster(maxHp)
	if self._masterWidget then
		self._masterWidget:setRp(self:getShowRpNum(self._dataModel:getRp()))
	end

	if self._headWidget then
		self._headWidget:setHp(self._dataModel:getHp(), maxHp)
		self._headWidget:setRp(self:getShowRpNum(self._dataModel:getRp()), self._dataModel:getMaxRp())
	end

	if self._heroHeadWidget then
		self._heroHeadWidget:updateHeroHpInfo(self._id, self._dataModel:getHp(), maxHp)
	end

	if self._equipHpWidget then
		self._equipHpWidget:refreshHp(self._id, self._dataModel:getHp(), maxHp)
	end
end

function BattleRoleObject:goBack()
	if self._liveState == LiveState.Fleeing then
		return
	end

	if self:isInHomePlace() then
		self:stopMoving()
		self:actionEndCallback()

		return
	end

	if self._gobackDirty then
		return
	end

	local dur = self._backDur
	local homePlace = self._homePlace

	self:switchState("-run", {
		loop = -1,
		dur = dur
	})
	self:setBusyState(true)

	self._gobackDirty = true

	self:moveWithDuration(homePlace, dur / 1000, function()
		self:setBusyState(false)

		self._gobackDirty = false
	end)
end

function BattleRoleObject:forceGoBack(dur)
	dur = dur or 1000

	self:cancelThrown()
	self._activeNode:setPosition(0, 0)
	self:switchState("run", {
		loop = -1,
		dur = dur
	})

	local homePlace = self._homePlace

	self:setBusyState(true)

	self._gobackDirty = true

	self:moveWithDuration(homePlace, dur / 1000, function()
		self:setBusyState(false)

		self._gobackDirty = false
	end)
end

function BattleRoleObject:forceGoOutScreen(dur, posX, posY)
	dur = dur or 1000
	posX = posX or 0
	posY = posY or 0

	self:cancelThrown()
	self:switchState("-run", {
		loop = -1,
		dur = dur
	})
	self:setBusyState(true)

	self._gobackDirty = true

	local pos = {
		x = posX,
		y = posY
	}

	self:moveWithDuration(pos, dur / 1000, function()
		self:setBusyState(false)

		self._gobackDirty = false
	end)
end

function BattleRoleObject:tryDie()
	if self._flyTask == nil and self:isFree() and not self:isLive() then
		if self._animEnded then
			if self._liveState == LiveState.Remove then
				return false
			end

			self._liveState = LiveState.Dead

			self:die()

			return true
		else
			self:switchState("tanghao")
		end
	end

	return false
end

function BattleRoleObject:die()
	if self._liveState == LiveState.Remove or self._liveState == LiveState.Lived then
		return
	end

	self._liveState = LiveState.Remove

	local fadeOut = cc.FadeOut:create(0.2)
	local callback = cc.CallFunc:create(function()
		self._battleGround:resetGroundCell(self._dataModel:getCellId(), GroundCellStatus.NORMAL, self._dataModel)
		self._node:removeFromParent()
		self._unitManager:removeUnitById(self._id, self._dataModel:getCellId())
	end)

	self._roleAnim:runAction(cc.Sequence:create(fadeOut, callback))
end

function BattleRoleObject:remove()
	if self._liveState == LiveState.Remove then
		return
	end

	self._liveState = LiveState.Remove

	self._battleGround:resetGroundCell(self._dataModel:getCellId(), GroundCellStatus.NORMAL, self._dataModel)
	delayCallByTime(0, function()
		self._unitManager:removeUnitById(self:getId(), self._dataModel:getCellId())
	end)
end

function BattleRoleObject:kick()
	if self._liveState == LiveState.Remove then
		return
	end

	self._liveState = LiveState.Remove

	self._battleGround:resetGroundCell(self._dataModel:getCellId(), GroundCellStatus.NORMAL, self._dataModel)
	self._unitManager:removeUnitById(self._id, self._dataModel:getCellId())

	local fadeOut = cc.FadeOut:create(0.2)

	if self._equipHpWidget then
		self._equipHpWidget:refreshHp(self._id, 0)
	end

	local callback = cc.CallFunc:create(function()
		self._node:removeFromParent()

		self._node = nil
	end)

	self._roleAnim:runAction(cc.Sequence:create(fadeOut, callback))
end

function BattleRoleObject:doReborn(args)
	local raw = args.hp < 0 and math.abs(args.hp) or args.hp

	self:addHealth(raw)
	self._roleAnim:stopAllActions()

	self._liveState = LiveState.Lived

	self:switchState("stand", {
		loop = -1
	}, true)
end

function BattleRoleObject:moveWithDuration(targetPos, duration, onReached)
	self:stopMoving()

	local from = self:getRelPosition()
	local to = targetPos
	local extraZ = (to.x ~= self._homePlace.x or to.y ~= self._homePlace.y) and ROLE_TOP_ZORDER or nil

	self._moveTask = self._context:runActionTask(duration, function(p)
		local speed = {
			x = (to.x - from.x) / duration,
			y = (to.y - from.y) / duration
		}
		local t = duration * p
		local pos

		if p < 0.5 then
			pos = {
				x = from.x + 2 * speed.x * t * t / duration,
				y = from.y + 2 * speed.y * t * t / duration
			}
		elseif p < 1 then
			pos = {
				x = from.x + 4 * speed.x * t - 2 * speed.x * t * t / duration - speed.x * duration,
				y = from.y + 4 * speed.y * t - 2 * speed.y * t * t / duration - speed.y * duration
			}
		elseif p == 1 then
			pos = to
		end

		self:setRelPosition(pos, ROLE_TOP_ZORDER, kRelPosWithHeight)
	end, function()
		self._moveTask = nil

		if onReached ~= nil then
			onReached(self)
		end

		if extraZ == nil then
			self:setRelPosition(self:getRelPosition())
		end

		if self._state == "run" then
			self:actionEndCallback()
		end

		if to.x == self._homePlace.x then
			local forward = self._isLeftTeam and 1 or -1

			self:setForward(forward)
		end
	end)
end

local skillList = {
	"attack",
	"skill1",
	"skill2",
	"skill3",
	"skill4",
	"skill5",
	"dieskill",
	"skill1_1",
	"skill1_2",
	"skill1_3",
	"skill1_4",
	"skill1_5",
	"skill3_1",
	"skill3_2",
	"skill3_3",
	"skill3_4",
	"skill2_1",
	"skill2_2",
	"skill2_3",
	"skill2_4",
	"skill5_1",
	"skill5_2",
	"skill5_3"
}
local normalList = {
	"down",
	"getup",
	"run",
	"stand",
	"win",
	"hurt",
	"hurt1",
	"debut",
	"fail",
	"charge",
	"squat",
	"burst"
}
local actMap = {
	debut = "stand",
	skill2 = "skill2",
	lockdie = "die",
	fakedie = "die",
	squat = "squat",
	skill1_3 = "skill1_3",
	skill1_4 = "skill1_4",
	die2 = "die2",
	skill3_3 = "skill3_3",
	dieskill = "dieskill",
	charge = "charge",
	down = "down",
	attack = "skill1",
	skill3 = "skill3",
	skill3_2 = "skill3_2",
	run = "run",
	skill2_3 = "skill2_3",
	skill5_2 = "skill5_2",
	stand = "stand",
	skill3_1 = "skill3_1",
	skill3_4 = "skill3_4",
	win = "win",
	hurt = "hurt1",
	skill1 = "skill1",
	hurt1 = "hurt1",
	burst = "burst",
	skill1_5 = "skill1_5",
	skill2_1 = "skill2_1",
	skill5_1 = "skill5_1",
	getup = "getup",
	skill4 = "skill4",
	skill5_3 = "skill5_3",
	skill5 = "skill5",
	skill2_4 = "skill2_4",
	die = "die",
	walk = "run",
	skill1_1 = "skill1_1",
	fail = "stand",
	skill1_2 = "skill1_2",
	skill2_2 = "skill2_2"
}

local function startsWith(src, sub)
	local len = string.len(sub)

	return string.sub(src, 1, len) == sub
end

function BattleRoleObject:switchState(state, extra, always, callback)
	if self:getId() == specId then
		Bcallstack("changeState", state, "extra:", extra or "nil", "time:", os.clock(), "from:", self._state, "isBusy:", self._isBusy)
	end

	local isPrologue = self._context:getValue("Prologue")

	if not always then
		if not self:canChangeState(state) then
			if self._state == state then
				self.animCallback = self.animCallback or callback
			end

			return false
		end

		if startsWith(state, "hurt") and self._state ~= "stand" and self._state ~= "charge" and not startsWith(self._state, "hurt") then
			return false
		end

		if startsWith(state, "down") and self._state ~= "stand" and self._state ~= "charge" and not startsWith(self._state, "hurt") and self._state ~= "down" then
			return false
		end

		if startsWith(state, "tanghao") and self._state == "lockdie" then
			return false
		end
	end

	local forward = 1

	if string.sub(state, 1, 1) == "-" then
		forward = self:isLeft() and -1 or 1
		state = string.sub(state, 2)
	else
		forward = self:isLeft() and 1 or -1
	end

	self:setForward(forward)

	local anim = self._roleAnim

	self.animCallback = callback or nil

	local stateAct = actMap[state]

	if not self:isLive() and self:isFree() then
		if isPrologue then
			self._state = state

			self:die()
		elseif self._state ~= "down" then
			self._state = "down"

			anim:resumeAnimation()

			if anim:hasAnimation("die") and not self._finalHitDown then
				anim:playAnimation(0, "die", false)

				if self._context:getValue("FinalHit") == true and self._roleType == RoleType.Master then
					local mainMediator = self._context:getValue("BattleMainMediator")

					mainMediator:showFinalDieAnim(self)

					if not self:isLeft() then
						mainMediator:showFinalTaskFinish(self)
					end

					self._finalHitDown = true
				end

				self:playSpecialSound("die")
			else
				self:die()
			end
		else
			anim:pauseAnimation()

			self._animEnded = true

			if self._context:getValue("FinalHit") == true and self._roleType == RoleType.Master then
				local mainMediator = self._context:getValue("BattleMainMediator")

				if not self:isLeft() then
					mainMediator:showFinalTaskFinish(self)
				end

				if mainMediator:showFinalDieAnim(self) then
					return false
				end
			end

			self:tryDie()
		end

		return false
	end

	if stateAct == nil then
		return false
	end

	local busy = false

	extra = extra or {}

	for _, skill in ipairs(skillList) do
		if self._state == skill then
			anim:removeUserEventForAnimation(skill)
		end

		if state == skill then
			self:parseSkillTimeline(stateAct, extra.specialEvts)

			busy = true
		end
	end

	local start = extra.strt

	if not extra.loop then
		local loop = 1

		if extra.dur then
			if not (extra.dur / 1000) then
				local animDur

				self._animLoop = loop

				if anim:isAnimationPaused() then
					anim:resumeAnimation()
				end

				if self._dataModel:getAwakenLevel() > 0 then
					if stateAct == "stand" then
						stateAct = "stand1"
					end

					if stateAct == "squat" then
						stateAct = "squat1"
					end
				end

				if anim:hasAnimation(stateAct) then
					anim:playAnimation(0, stateAct, true)
				else
					stateAct = "stand"
					self._state = "stand"

					anim:playAnimation(0, "stand", true)
				end

				if start then
					anim:playAnimationInFrameIndex(0, stateAct, start, true)
				else
					anim:playAnimation(0, stateAct, true)
				end

				if loop == 0 then
					anim:pauseAnimation()
				end

				if self._animTask then
					self._animTask:stop()

					self._animTask = nil
				end

				if animDur then
					local scheduler = self:getContext():getScalableScheduler()

					self._animTask = scheduler:schedule(function(task, dt)
						animDur = animDur - dt

						if animDur <= 0 then
							task:stop()

							self._animTask = nil

							self:actionEndCallback()
						end
					end)
				end

				self._state = state

				return true
			end
		end
	end
end

function BattleRoleObject:parseSkillTimeline(actionName, specialEvts)
	local modelCfg = self._dataModel:getModelConfig()
	local animId = modelCfg.Animation
	local skillId = animId .. "_" .. actionName

	if specialEvts then
		skillId = specialEvts
	end

	local skillConfig = ConfigReader:getRecordById("SkillAnima", skillId)

	if not skillConfig then
		assert(false, tostring(skillId) .. " not exists in SkillAnima." .. "\nId:" .. tostring(self._id) .. "\nanimId:" .. tostring(animId) .. "\nactionName:" .. tostring(actionName) .. "\nSpecialEvts:" .. tostring(specialEvts))
	end

	local frameEvts = skillConfig.events
	local anim = self._roleAnim

	anim:removeUserEventForAnimation(actionName)

	local i = 0

	for _, cfg in ipairs(frameEvts) do
		local frame = cfg.f

		if not cfg.evts then
			for _, evt in ipairs(cfg.evts) do
				local name = evt.e .. i

				if not evt.d then
					local data = {}

					table.deepcopy(evt.d, data)

					data.eventType = evt.e

					local dataStr = cjson.encode(data)

					anim:addUserEventForStringEx(actionName, name, frame, dataStr)

					i = i + 1
				end
			end
		end
	end
end

function BattleRoleObject:switchAction(srcAnim, descAnim)
	if self._roleAnim:hasAnimation(descAnim) then
		if self._actionTransform[srcAnim] and self._actionTransform[srcAnim] == descAnim then
			return
		end

		self._actionTransform[srcAnim] = descAnim
		self._actionTransformRevise[descAnim] = srcAnim

		for k, v in pairs(skillList) do
			if v == descAnim then
				self._roleAnim:removeUserEventForAnimation(srcAnim)
				self:parseSkillTimeline(descAnim)

				break
			end
		end
	end
end

function BattleRoleObject:changeActionLoop(descAnim, isLoop)
	if self._roleAnim:hasAnimation(descAnim) then
		self._actionLoopMap = self._actionLoopMap or {}
		self._actionLoopMap[descAnim] = isLoop
	end
end

function BattleRoleObject:clearAllTransformAction()
	self._actionTransform = {}
	self._actionTransformRevise = {}
end

function BattleRoleObject:canChangeState(newState)
	if self:isBusyState() then
		for _, v in ipairs(normalList) do
			if newState == v then
				return false
			end
		end
	end

	return true
end

function BattleRoleObject:setBusyState(val)
	if self:getId() == specId then
		Bcallstack(self._id, "setBusyState", val)
	end

	self._isBusy = val
end

function BattleRoleObject:isBusyState()
	return self._isBusy
end

function BattleRoleObject:isBlockByActId(actId)
	return self._dataModel:getBlockInfo(actId)
end

function BattleRoleObject:actionEndCallback()
	self._animLoop = nil

	local forward = self._isLeftTeam and 1 or -1

	self:setForward(forward)

	if self._state ~= "fail" then
		if self._state == "win" then
			self._roleAnim:pauseAnimation()
		elseif self._roleType == RoleType.Master or self._dataModel:getRp() < self._dataModel:getMaxRp() then
			self:switchState("stand", {
				loop = -1
			})
		else
			self:switchState("charge", {
				loop = 1
			})
		end
	end

	if self.animCallback then
		self.animCallback()
	end
end

function BattleRoleObject:pauseAnim(frameIndex)
	self._roleAnim:setAnimationFrameIndex(0, frameIndex)
	self._roleAnim:pauseAnimation()
end

function BattleRoleObject:createBehaviorNode(args)
	local behaviorNode

	repeat
		if args.seq then
			behaviorNode = SequenceBehavior:new(self:arrIterator(args.seq))

			do break end
			break
		end

		if args.par then
			behaviorNode = ParallelSelectorBehavior:new(self:arrIterator(args.par))

			do break end
			break
		end

		if args.name and args.name == "ShiftMove" then
			behaviorNode = BattleMoveBehaviorNode:new(args)

			do break end
			break
		end

		if args.name and args.name == "Animation" then
			do
				local param = {
					name = args.actName,
					loop = args.loop,
					dur = args.dur,
					strt = args.strt
				}

				behaviorNode = BattleActionBehaviorNode:new(param)

				break
			end

			break
		end

		local cfgArr = {}
		local param = {}

		if args.move then
			local moveParam = {}

			table.deepcopy(args.move, moveParam)

			moveParam.name = "ShiftMove"
			cfgArr[#cfgArr + 1] = moveParam
			param = moveParam
		end

		if args.name then
			local actParam = {
				name = "Animation",
				actName = args.name,
				loop = args.loop,
				dur = args.dur,
				strt = args.strt
			}

			cfgArr[#cfgArr + 1] = actParam
			param = actParam
		end

		if #cfgArr > 1 then
			behaviorNode = ParallelSelectorBehavior:new(self:arrIterator(cfgArr))

			do break end
			break
		end

		if #cfgArr == 1 then
			behaviorNode = self:createBehaviorNode(param)
		end

		break
	until true

	behaviorNode = behaviorNode or EmptyBehaviorNode:new()

	if args.delay then
		return DelayBehaviorNode:new(behaviorNode, args.delay)
	end

	return behaviorNode
end

function BattleRoleObject:arrIterator(configArr)
	local function f(ctx, ctrlVar)
		local action

		while action == nil do
			ctrlVar = ctrlVar + 1

			if ctrlVar > #configArr then
				return
			else
				action = self:createBehaviorNode(configArr[ctrlVar])
			end
		end

		return ctrlVar, action
	end

	return f, 0
end

function BattleRoleObject:settle()
	if not self._topBar:scheduleShowHp() and not self._hiding then
		return
	end

	self._frontActiveFla:setVisible(true)
	self._backActiveFla:setVisible(true)
	self._frontFlaNode:setVisible(true)
	self._backFlaNode:setVisible(true)
	self._topFlaNode:setVisible(true)
	self._bottomFlaNode:setVisible(true)

	if self._hiding then
		self._hiding = nil

		self._roleAnim:setVisible(true)
		self._roleAnim:setColorTransform(self._baseColorTrans)
		self:switchState("squat", {
			loop = 1
		})
		AudioEngine:getInstance():playEffect("Se_Alert_Unique_Skill", false)
	end

	self._battleGround:resetGroundCell(self._dataModel:getCellId(), GroundCellStatus.OCCUPIED)
end

function BattleRoleObject:playWinOrLoseAnim(result)
	if result == 1 and self._isLeftTeam or result == -1 and not self._isLeftTeam then
		self:switchState("win", {
			loop = 1
		})
	elseif result == -1 and self._isLeftTeam or result == 1 and not self._isLeftTeam then
		if self:isLive() then
			self._specialSoundDisabled = true
			self._liveState = LiveState.Dying
		end

		self:tryDie()
	end

	local forward = self._isLeftTeam and 1 or -1

	self:setForward(forward)
end

function BattleRoleObject:isDieAnim(animName)
	return animName == "die" or animName == "die_1" or animName == "die_5" or animName == "die_6" or animName == "die_7" or animName == "die_8"
end

function BattleRoleObject:isDownAnim(animName)
	return animName == "down" or animName == "down_2" or animName == "down_3" or animName == "down_4"
end

function BattleRoleObject:spineHandler(event)
	if event.type == "complete" then
		if event.animation == "debut" and self._liveState == LiveState.Lived then
			self:switchState("stand", {
				loop = -1
			})

			return
		end

		if self:isDownAnim(event.animation) then
			if self:isLive() then
				self:switchState("getup")

				return
			else
				self._animEnded = true

				self:tryDie()

				return
			end
		end

		if self:isDieAnim(event.animation) then
			if self._state == "fakedie" or self._state == "lockdie" then
				self._roleAnim:pauseAnimation()

				return
			end

			self._animEnded = true

			self:tryDie()

			return
		end

		if not self._animLoop or self._animLoop <= 0 then
			return
		end

		self._animLoop = self._animLoop - 1

		if self._animLoop > 0 then
			local extra = {
				loop = self._animLoop
			}

			self:switchState(self._state, extra, true)
		else
			local frameCount = self._roleAnim:getAnimationFrames(event.animation)

			self._roleAnim:goToFrameIndexAndPaused(0, frameCount - 1)

			if self._animTask == nil then
				self:actionEndCallback()
			end
		end

		return
	end

	local handler = self:getContext():getValue("SpineHandler")
	local eventData = event.eventData
	local argsStr = eventData.stringValue
	local params = cjson.decode(argsStr)

	if not params then
		DpsLogger:debug("battle", "Invalid events in '{}'", event.animation)

		return
	end

	local action = params.eventType

	action = action:sub(1, 1):upper() .. action:sub(2)

	local func = handler["spineHandler_" .. action]

	if func == nil then
		DpsLogger:debug("battle", "BattleRoleObject skipped spine handler '{}'", action)

		return
	end

	func(handler, event, params, self)
end

function BattleRoleObject:onHpChanged(event)
	local data = event:getData()

	if self._id ~= data.roleId then
		return
	end

	local hpPercent = self._dataModel:getHp() / self._dataModel:getMaxHp() * 100

	self._topBar:setHp(hpPercent)
	self:syncMainViewMaster(data.maxHp)
	self._topBar:scheduleShowHp()

	if self._dataModel:getHp() <= 0 and not self._dataModel:getIsProcessingBoss() and self._roleType == RoleType.Master then
		local mainMediator = self._context:getValue("BattleMainMediator")

		mainMediator:showFinalHitAnim(self)
	end
end

function BattleRoleObject:onShieldChanged(event)
	self._topBar:refreshShield()
end

function BattleRoleObject:onRpChanged(event)
	local data = event:getData()

	if self._id ~= data.roleId then
		return
	end

	self:syncMainViewMaster()

	local mpPercent = self:getShowRpNum(self._dataModel:getRp()) / self._dataModel:getMaxRp() * 100

	self._topBar:setRp(mpPercent)

	if self._roleType == RoleType.Master then
		local anim = self._frontActiveFla:getChildByName("nlm")

		if mpPercent >= 100 then
			if not anim then
				anim = cc.MovieClip:create("mannu_mannu")

				anim:setBlendMode(1)

				local node = cc.Node:create():addTo(self._frontActiveFla)

				node:setScaleX(self:isLeft() and -1 or 1)
				node:setName("nlm")
				anim:posite(0, 68):addTo(node)
			end
		elseif anim then
			anim:removeFromParent()
		end
	end

	self._topBar:scheduleShowRp()
end

function BattleRoleObject:onFilmEvent()
	self._filmedNum = self._filmedNum + 1
	self._filmed = true

	self:refreshColor()
end

function BattleRoleObject:onUnFilmEvent()
	self._filmedNum = self._filmedNum - 1
	self._filmedNum = math.max(self._filmedNum, 0)
	self._filmed = self._filmedNum > 0

	self:refreshColor()
end

function BattleRoleObject:speakBubble(args)
	if self._bubble then
		self._bubble:removeView()

		self._bubble = nil
	end

	local resPath = "asset/ui/BattleBubbleWidget.csb"
	local node = cc.CSLoader:createNode(resPath)
	local bubble = BattleBubbleWidget:new(node, args, function(sender)
		if self._bubble then
			self._bubble:removeView()

			self._bubble = nil
		end
	end)

	bubble:autoDispose()

	local pos = cc.p(-self:getModelWidth() / 2 - 45, self:getModelHeight() + 30)

	bubble:getView():setPosition(pos)
	bubble:getView():addTo(self._bubbleNode)
	bubble:setViewContext(self._context)

	self._bubble = bubble
end

function BattleRoleObject:emoteBubble(args)
	if self._bubble then
		self._bubble:removeView()

		self._bubble = nil
	end

	local node = cc.Node:create()
	local bubble = BattleEmoteWidget:new(node, args, function(sender)
		if self._bubble then
			self._bubble:removeView()

			self._bubble = nil
		end
	end)
	local pos = cc.p(self:getModelWidth() / 2, self:getModelHeight() + 30)

	if not self:isLeft() then
		bubble:getView():setScaleX(-1)

		pos = cc.p(-self:getModelWidth() / 2, self:getModelHeight() + 30)
	end

	bubble:getView():setPosition(pos)
	bubble:getView():addTo(self._bubbleNode, 101)
	bubble:setViewContext(self._context)

	self._bubble = bubble
end

function BattleRoleObject:RtpkEmoji(args)
	if self._rtpkbubble then
		self._rtpkbubble:removeView()

		self._rtpkbubble = nil
	end

	local resFile = "asset/ui/EmojiTopTalkWidget.csb"
	local node = cc.CSLoader:createNode(resFile)
	local _rtpkbubble = BattleRTPKEmoteWidget:new(node, args, function(sender)
		if self._rtpkbubble then
			self._rtpkbubble:removeView()

			self._rtpkbubble = nil
		end
	end)
	local pos = cc.p(self:getModelWidth() / 2, self:getModelHeight() - 100)

	if not self:isLeft() then
		_rtpkbubble:getView():setScaleX(-1)

		pos = cc.p(-self:getModelWidth() / 2, self:getModelHeight() - 100)
	end

	_rtpkbubble:getView():setPosition(pos)
	_rtpkbubble:getView():addTo(self._rtpkBubbleNode, 101)
	_rtpkbubble:setViewContext(self._context)

	self._rtpkbubble = _rtpkbubble
end

function BattleRoleObject:addActivateNums(actId)
	if not self._activeTags[actId] then
		self._activeTags[actId] = true
		self._activateNum = self._activateNum + 1

		if self._id == specId then
			Bcallstack("addActivateNum", actId, self._activateNum)
		end
	end
end

function BattleRoleObject:subActivateNums(actId)
	if not self._activeTags[actId] then
		return
	end

	self._activeTags[actId] = false
	self._activateNum = math.max(self._activateNum - 1, 0)

	if self._id == specId then
		Bcallstack("subActivateNum", actId, self._activateNum)
	end

	self:tryDie()

	if self:isFree() and self:isLive() then
		self:tryResetState()
	end

	if self:isFree() and not self:isLive() and self._state == "stand" then
		-- block empty
	end
end

function BattleRoleObject:isFree()
	return self._activateNum == 0
end

function BattleRoleObject:shiftPosition(v, a, dur)
	if a == nil then
		a = {
			0,
			0
		}
	end

	if v == nil then
		v = {
			0,
			0
		}
	end

	if not self:isLeft() then
		v = {
			-v[1],
			v[2]
		}
		a = {
			-a[1],
			a[2]
		}
	end

	v = {
		v[1] * 0.4,
		v[2] * 0.3333333333333333
	}
	a = {
		a[1] * 0.4,
		a[2] * 0.3333333333333333
	}

	local startPos = self:getRelPosition()
	local curZorder = self:getView():getLocalZOrder()

	self._shiftPosTask = self:getContext():runActionTask(dur, function(p)
		local t = dur * p
		local offsetX = v[1] * t + 0.5 * a[1] * t^2
		local offsetY = v[2] * t + 0.5 * a[2] * t^2
		local offset = cc.p(offsetX, offsetY)
		local curPos = cc.pAdd(startPos, offset)

		self:setRelPosition(curPos, kRoleTopZOrder)
		self:getView():setLocalZOrder(curZorder)
	end, function()
		self._shiftPosTask = nil
	end)
end

function BattleRoleObject:offsetPosition(x, y)
	if self._displacement == nil then
		self._displacement = {
			0,
			0
		}
	end

	self._displacement[1] = self._displacement[1] + x * (self:isLeft() and 1 or -1)
	self._displacement[2] = self._displacement[2] + y

	local x0 = self._displacement[1] * kMeasuringScale
	local y0 = self._displacement[2] * kMeasuringScale
	local activeNode = self._activeNode

	activeNode:setPosition(x0, y0)
end

function BattleRoleObject:dieHide()
	if self._liveState == LiveState.Remove then
		return
	end

	self:getView():setVisible(false)
end

function BattleRoleObject:hideRole(opacity)
	self._topBar:setHpVisible(false)
	self._iconContainer:setVisible(false)
	self._topBar:setRpVisible(false)

	self._topBarVisibleSta = false

	if self._topBar.bg then
		self._topBar.bg:setVisible(false)
	end

	if opacity > 0 then
		local trans = {}

		table.deepcopy(self._baseColorTrans, trans)

		local mults, offsets = trans.mults, trans.offsets

		self._roleAnim:setColorTransform(ColorTransform(0.3, 0.3, 0.3, mults.w, offsets.x, offsets.y, offsets.z, offsets.w))
	else
		self._roleAnim:setVisible(false)
	end

	self._hiding = true
end

function BattleRoleObject:playSound(file, rate)
	local random = math.random()

	if rate < random then
		return
	end

	local handle = AudioEngine:getInstance():playEffect(file, false)
end

function BattleRoleObject:playVoice(file, rate)
	local random = math.random()

	if rate < random then
		return
	end

	local handle = AudioEngine:getInstance():playRoleEffect(file, false)
end

local SpecialSoundMap = {
	down = "_30",
	hurt = "_29",
	die = "_32"
}

function BattleRoleObject:playSpecialSound(act, actId)
	if self._specialSoundDisabled then
		return
	end

	if SpecialSoundMap[act] then
		if actId then
			if self._specialSoundRec and self._specialSoundRec[act] and self._specialSoundRec[act][actId] then
				return
			end

			self._specialSoundRec = self._specialSoundRec or {}
			self._specialSoundRec[act] = self._specialSoundRec[act] or {}
			self._specialSoundRec[act][actId] = true

			AudioEngine:getInstance():playRoleEffect("Voice_" .. self._dataModel:getModelConfig().Hero .. SpecialSoundMap[act], false)
		else
			AudioEngine:getInstance():playRoleEffect("Voice_" .. self._dataModel:getModelConfig().Hero .. SpecialSoundMap[act])
		end
	end
end

function BattleRoleObject:freezeFrame(actName, frame)
	local anim = self._roleAnim

	self:switchState(actName)
	anim:goToFrameIndexAndPaused(0, frame)
end

function BattleRoleObject:shake(frameCount)
	if self._pauseTask then
		self._pauseTask:stop()

		self._pauseTask = nil
	end

	local onceMoveDur = 0.033
	local duration = onceMoveDur * frameCount
	local offsetX = 2
	local anim = self._roleAnim
	local activeNode = self._activeNode

	activeNode:setPosition(0, 0)
	anim:pauseAnimation()

	self._pauseTask = self:getContext():runActionTask(duration, function(p)
		offsetX = -1 * offsetX

		activeNode:setPositionX(activeNode:getPositionX() + offsetX)
	end, function()
		anim:resumeAnimation()
		activeNode:setPosition(0, 0)

		self._pauseTask = nil
	end)
end

function BattleRoleObject:thrown(force, callback, state)
	local flag = {
		a4 = 12,
		a3 = 8,
		a2 = 6,
		a1 = 0
	}
	local anim = self._roleAnim
	local activeNode = self._activeNode

	self:switchState(state or "down")
	anim:goToFrameIndexAndPaused(0, flag.a1)

	if self._displacement == nil then
		self._displacement = {
			0,
			0
		}
	end

	if not self._velocity then
		local velocity = {
			0,
			0
		}
		local xdist = self._displacement[1]
		local height = self._displacement[2]

		xdist = math.max(0, xdist)
		height = math.max(0, height)
		self._velocity = {
			force[1],
			math.max(velocity[2], 0) + force[2] / (1 + height)
		}

		local time = 0

		if self._flyTask == nil then
			self._flyTask = self._context:scalableSchedule(function(task, dt)
				local d = self._displacement
				local velocity = self._velocity

				self._velocity = {
					velocity[1],
					velocity[2] - kGravity * dt
				}
				velocity[2] = (velocity[2] + self._velocity[2]) * 0.5
				self._displacement[1] = d[1] + velocity[1] * dt
				self._displacement[2] = d[2] + velocity[2] * dt

				local finish = false

				if self._displacement[2] <= 0 then
					self._displacement[2] = 0
					finish = true
				end

				local x = self._displacement[1] * kMeasuringScale
				local y = self._displacement[2] * kMeasuringScale

				activeNode:setPosition(x, y)

				self._frameLabel = velocity[2] > 1 and flag.a1 or velocity[2] > 0 and flag.a2 or velocity[2] > -1 and flag.a3 or flag.a4
				time = time + dt

				anim:resumeAnimation()
				anim:goToFrameIndexAndPaused(0, self._frameLabel)

				if finish then
					task:stop()

					self._flyTask = nil
					self._velocity = nil
					self._displacement = nil
					self._frameLabel = nil

					self:tryDie()

					if self._animEnded then
						anim:resumeAnimation()
						anim:playAnimationInFrameIndex(0, "down", flag.a4, false)
					else
						anim:resumeAnimation()
					end
				end
			end, 0, true)
		end
	end
end

function BattleRoleObject:thrownKick()
	self:thrown({
		-9,
		10
	}, nil, "hurt")

	local activeNode = self._activeNode

	activeNode:runAction(cc.RepeatForever:create(cc.RotateBy:create(0.05, -70)))
end

function BattleRoleObject:setBarAndBuffVisble(visible)
	self._topBarContainer:setVisible(visible)
	self._frontActiveFla:setVisible(visible)
	self._backActiveFla:setVisible(visible)
end

function BattleRoleObject:addSolidEffect(mcFile, loop, dot, layer, zOrder, callback)
	if not mcFile then
		return
	end

	loop = loop or 1
	layer = layer or "front"
	dot = dot or {
		x = 0.5,
		y = 0.5
	}
	dot.x = dot.x or 0.5
	dot.y = dot.y or 0.5

	local anim = cc.MovieClip:create(mcFile, "BattleMCGroup")

	anim:addEndCallback(function(cid, mc)
		loop = loop - 1

		if loop == 0 then
			mc:stop()
			mc:removeFromParent(true)
		end

		if callback then
			callback()
		end
	end)

	local point = cc.p(self:getModelWidth() * dot.x - self:getModelWidth() * 0.5, self:getModelHeight() * dot.y)

	anim:addTo((layer == "front" or nil) and (self._frontFlaNode or self._backFlaNode))
	anim:setLocalZOrder(layer == "front" and zOrder or -zOrder)
	anim:setPosition(point)

	return anim
end

function BattleRoleObject:prepareSkillEffect(effectId, performAct, animation)
	if not self._skillEffect[performAct] then
		local actEffects = {}

		self._skillEffect[performAct] = actEffects

		local effect = actEffects and actEffects[effectId]

		if effect then
			effect:setVisible(false)
			effect:pause(true)
		else
			local config = ConfigReader:getRecordById("SkillVideo", effectId)

			if config then
				local file = config.File
				local width = config.Size[1]
				local height = config.Size[2]
				local offset = cc.p(-config.Offset[1], config.Offset[2])
				local anchor = cc.p(config.SpineAnchor[1], config.SpineAnchor[2])
				local zOrder = 10

				effect = VideoSprite.createSkillVideo("video/skill/" .. file)

				effect:setContentSize(cc.size(width, height))

				local layer = config.Layer

				if config.Bone and config.Bone ~= "" then
					local node = cc.Node:create()

					node:addTo((layer == "front" or nil) and (self._frontFlaNode or self._backFlaNode))
					node:setLocalZOrder(layer == "front" and zOrder or -zOrder)

					local scale = 1 / self._roleAnim:getScale() / 0.953

					effect:addTo(node):posite(offset.x * scale, offset.y * scale)
					effect:setAnchorPoint(cc.p(config.Anchor[1], config.Anchor[2]))
					effect:setScale(scale)

					local mat4 = node:getParentToNodeTransform()

					mat4 = cc.mat4.new(mat4)

					self._roleAnim:bindAttachingNode(animation, config.Bone, node, mat4)
					effect:setCallback(function(instance, eventName)
						if eventName == "complete" and actEffects[effectId] then
							self._roleAnim:unbindAttachingNode(node)
							node:removeFromParent()

							actEffects[effectId] = nil
						end
					end)

					actEffects[effectId] = effect
				else
					local scale = 1.0493179433368311 * self._modelScale

					width = width * scale
					height = height * scale
					offset = cc.p(offset.x * scale, offset.y * scale)

					local point = cc.p(self:getModelWidth() * anchor.x + offset.x - self:getModelWidth() * 0.5, self:getModelHeight() * anchor.y + offset.y)

					effect:setScale(scale)
					effect:setAnchorPoint(cc.p(config.Anchor[1], config.Anchor[2]))
					effect:setPosition(point)
					effect:addTo((layer == "front" or nil) and (self._frontFlaNode or self._backFlaNode))
					effect:setLocalZOrder(layer == "front" and zOrder or -zOrder)

					actEffects[effectId] = effect

					effect:setCallback(function(instance, eventName)
						if eventName == "complete" then
							effect:removeFromParent()

							actEffects[effectId] = nil
						end
					end)
				end

				if layer == "front" then
					effect:setGlobalZOrder(10)
				else
					effect:setGlobalZOrder(-10)
				end

				effect:setSpeed(self._context:getTimeScale())
				effect:pause(true)
				effect:setVisible(false)
			end
		end
	end
end

function BattleRoleObject:setDisplayZorder(order)
	self:getView():setLocalZOrder(order)

	self._specialZorder = order
end

function BattleRoleObject:resetDisplayZorder()
	self._specialZorder = nil

	self:setRelPosition(self:getRelPosition())
end

function BattleRoleObject:startSkillEffect(effectId, performAct, animation)
	local actEffects = self._skillEffect[performAct]
	local effect = actEffects and actEffects[effectId]

	if effect and effect:isPaused() then
		effect:setVisible(true)
		effect:pause(false)
	end
end

function BattleRoleObject:clearSkillEffect(performAct)
	local actEffects = self._skillEffect[performAct]

	if actEffects then
		for effectId, effect in pairs(actEffects) do
			local config = ConfigReader:getRecordById("SkillVideo", effectId)

			if config.Bone and config.Bone ~= "" then
				local node = effect:getParent()

				self._roleAnim:unbindAttachingNode(node)
				node:removeFromParent()
			else
				effect:removeFromParent()
			end
		end

		self._skillEffect[performAct] = nil
	end
end

function BattleRoleObject:startSkillMovie(movieId, performAct)
	if not self._skillMovies[performAct] then
		local movies = {}

		self._skillMovies[performAct] = movies

		local movie = movies and movies[movieId]

		if movie then
			movie:gotoAndPlay(1)
		else
			local config = ConfigReader:getRecordById("SkillMovie", movieId)

			if config then
				if self._context:getValue("ShowSkillEffect") ~= BattleEffect_ShowType.All then
					local loads = config.Load

					for _, picname in ipairs(loads) do
						if not MemCacheUtils:hasPlist("asset/anim/" .. picname .. ".plist") then
							if app and app.pkConfig and app.pkgConfig.hideNotCachedSkillFlash == 1 then
								local mainMediator = self._context:getValue("BattleMainMediator")

								mainMediator:dispatch(ShowTipEvent({
									tip = movieId .. "加载时间不够，不显示"
								}))
							end

							return false
						end
					end
				end

				local animName = config.Anim

				print(animName)

				local offset = cc.p(-config.Offset[1], config.Offset[2])
				local anchor = cc.p(config.SpineAnchor[1], config.SpineAnchor[2])
				local zOrder = 10

				movie = cc.MovieClip:create(animName, "BattleMCGroup")

				local layer = config.Layer
				local scale = kRoleScale

				offset = cc.p(offset.x * scale, offset.y * scale)

				local point = cc.p(self:getModelWidth() * anchor.x + offset.x - self:getModelWidth() * 0.5, self:getModelHeight() * anchor.y + offset.y)

				movie:setScale(scale)
				movie:setPosition(point)

				if layer == "front" then
					movie:addTo(self._frontFlaNode)
					movie:setLocalZOrder(zOrder)
				elseif layer == "top" then
					movie:addTo(self._topFlaNode)
				elseif layer == "bottom" then
					movie:addTo(self._bottomFlaNode)
				else
					movie:addTo(self._backFlaNode)
					movie:setLocalZOrder(-zOrder)
				end

				movies[movieId] = movie

				movie:addEndCallback(function(cid, mc)
					mc:stop()
					movie:removeFromParent(true)

					movies[movieId] = nil

					self:unloadSkillMovie(movieId)
				end)
			end
		end
	end
end

function BattleRoleObject:unloadSkillMovie(movieId)
	local config = ConfigReader:getRecordById("SkillMovie", movieId)
	local loads = config.Load

	for _, picname in ipairs(loads) do
		MemCacheUtils:releasePlist("asset/anim/" .. picname .. ".plist", "battle")
	end
end

function BattleRoleObject:clearSkillMovie(performAct)
	local movies = self._skillMovies[performAct]

	if movies then
		for movieId, movie in pairs(movies) do
			movie:removeFromParent()
			self:unloadSkillMovie(movieId)
		end

		self._skillMovies[performAct] = nil
	end
end

function BattleRoleObject:flee(dur)
	dur = dur or 600

	local mainMediator = self._context:getValue("BattleMainMediator")
	local homePlace = self._homePlace
	local pos = self._battleGround:convertRelPosition2View(homePlace)

	pos = cc.p(pos.x - display.width * 0.6 * (self:isLeft() and 1 or -1), pos.y)

	local to = self._battleGround:convertView2RelPosition(pos)

	self:switchState("-run", {
		loop = -1,
		dur = dur
	})
	self:moveWithDuration(to, dur / 1000, function()
		self:remove()
	end)

	self._liveState = LiveState.Fleeing
end

function BattleRoleObject:spawnCallback()
	local mainMediator = self._context:getValue("BattleMainMediator")
	local delegate = mainMediator:getDelegate()

	if delegate and delegate.fighterIsSpawn then
		local heroId, wave = BattleSoleIdProcessor:splitBattleFighterId(self._id)

		delegate:fighterIsSpawn(mainMediator, heroId, self._id, wave)
	end
end

function BattleRoleObject:tryResetState()
	if self._shiftPosTask then
		self._shiftPosTask:stop()

		self._shiftPosTask = nil
	end

	if self:isBusyState() then
		return
	end

	self:setRelPosition(self._homePlace)

	if not self._animEnded and self._roleAnim:isAnimationPaused() then
		self._roleAnim:resumeAnimation()
	end
end

function BattleRoleObject:finalHitLock()
	self._state = "lockdie"
end

function BattleRoleObject:finalHitDie()
	self._animEnded = true

	self:tryDie()
end

function BattleRoleObject:holyHide(alpha)
	self._roleAnim:setOpacity(alpha * 255)
end

function BattleRoleObject:createDefaultModel()
	local pre = "asset/anim/"
	local jsonFile

	if self._roleType == RoleType.Master then
		jsonFile = pre .. "Master_LieSha.skel"

		self._dataModel:setModelId("Model_Master_LieSha")
	else
		jsonFile = pre .. "YFZZhu.skel"

		self._dataModel:setModelId("Model_YFZZhu")
	end

	return jsonFile
end

function BattleRoleObject:guideThrown(force, callback)
	local flag = {
		a4 = 12,
		a3 = 8,
		a2 = 6,
		a1 = 0
	}
	local anim = self._roleAnim
	local activeNode = self._activeNode

	self:switchState("down")
	anim:goToFrameIndexAndPaused(0, flag.a1)

	if self._displacement == nil then
		self._displacement = {
			0,
			0
		}
	end

	if not self._velocity then
		local velocity = {
			0,
			0
		}
		local xdist = self._displacement[1]
		local height = self._displacement[2]

		xdist = math.max(0, xdist)
		height = math.max(0, height)
		self._velocity = {
			force[1],
			math.max(velocity[2], 0) + force[2] / (1 + height)
		}

		local time = 0

		if self._flyTask == nil then
			self._flyTask = self._context:scalableSchedule(function(task, dt)
				local d = self._displacement
				local velocity = self._velocity

				self._velocity = {
					velocity[1],
					velocity[2] - kGravity * dt
				}
				velocity[2] = (velocity[2] + self._velocity[2]) * 0.5
				self._displacement[1] = d[1] + velocity[1] * dt
				self._displacement[2] = d[2] + velocity[2] * dt

				local finish = false

				if self._displacement[2] <= 0 then
					self._displacement[2] = 0
					finish = true
				end

				local x = self._displacement[1] * kMeasuringScale
				local y = self._displacement[2] * kMeasuringScale

				activeNode:setPosition(x, y)

				self._frameLabel = velocity[2] > 1 and flag.a1 or velocity[2] > 0 and flag.a2 or velocity[2] > -1 and flag.a3 or flag.a4
				time = time + dt

				anim:resumeAnimation()
				anim:goToFrameIndexAndPaused(0, self._frameLabel)

				if finish then
					task:stop()

					self._flyTask = nil
					self._velocity = nil
					self._displacement = nil
					self._frameLabel = nil

					self:tryDie()

					if self._animEnded then
						anim:resumeAnimation()
					else
						anim:resumeAnimation()
					end
				end
			end, 0, true)
		end
	end
end

function BattleRoleObject:guideMoveBy(force, callback)
	local activeNode = self._activeNode

	if not force[1] then
		if not force[2] then
			local x = -100

			if not force[3] then
				local y = 0

				activeNode:runAction(cc.MoveBy:create(force[1], cc.p(x, y)))
			end
		end
	end
end

function BattleRoleObject:guideHideObject()
	local rootNode = self._root

	rootNode:setVisible(false)
end

function BattleRoleObject:guideGoBattle()
	local rootNode = self._root

	rootNode:setVisible(true)
	self._roleAnim:setVisible(true)
	self._roleAnim:setColorTransform(self._baseColorTrans)
	self:switchState("squat", {
		loop = 1
	})
	AudioEngine:getInstance():playEffect("Se_Alert_Unique_Skill", false)
end

function BattleRoleObject:refreshHpBySetting()
	local hpShow = tonumber(self._context:getValue("ShowHpMode"))

	if self._topBarVisibleForceSta then
		self._topBar:setHpVisible(self._topBarVisibleSta)
		self._iconContainer:setVisible(self._topBarVisibleSta)
		self._topBar:setRpVisible(self._topBarVisibleSta)
	elseif hpShow == BattleHp_ShowType.Hide then
		self._topBar:setHpVisible(false)
		self._iconContainer:setVisible(false)
		self._topBar:setRpVisible(false)
	elseif hpShow == BattleHp_ShowType.Show then
		self._topBar:setHpVisible(true)
		self._iconContainer:setVisible(true)
		self._topBar:setRpVisible(true)
	elseif hpShow == BattleHp_ShowType.Simple then
		self._topBar:setHpVisible(self._topBarVisibleSta)
		self._iconContainer:setVisible(self._topBarVisibleSta)
		self._topBar:setRpVisible(self._topBarVisibleSta)
	end
end

function BattleRoleObject:showProfessionalRestraint(genre)
	self._professionalRestraintSupLab:setVisible(false)

	local battleSuppress = self._context:getValue("battleSuppress")

	if battleSuppress and battleSuppress[genre] then
		if not battleSuppress[genre].Sup then
			if battleSuppress[genre].Sup and self._dataModel:getGenre() and battleSuppress[genre].Sup[self._dataModel:getGenre()] then
				self._professionalRestraintSupLab:setVisible(true)

				return
			end
		end
	end
end

function BattleRoleObject:resumeProfessionalRestraint()
	self._professionalRestraintSupLab:setVisible(false)
end

function BattleRoleObject:modifyMaxHp(oldMax, MaxHp)
	self._topBar:setMaxHpValue(oldMax, MaxHp)
end

function BattleRoleObject:getShowRpNum(num)
	if self._isLeftTeam and self._roleType == RoleType.Master and self._context:getValue("unlockMasterSkill") == false then
		num = 0
	end

	return num
end

function BattleRoleObject:setRootVisible(isVisible)
	if isVisible then
		self._root.setVisible = cc.Node.setVisible

		self._root:setVisible(isVisible)
	else
		self._root:setVisible(isVisible)

		function self._root.setVisible()
			return
		end
	end
end

function BattleRoleObject:setRoleScale(scale)
	local baseScale = self._roleAnim:getScale()
	local sequence = cc.Sequence:create(cc.EaseBackOut:create(cc.ScaleTo:create(0.15, baseScale * scale)))

	self._roleAnim:runAction(sequence)

	self._modelScale = self._modelScale * scale
end

function BattleRoleObject:setHSVColor(hue, contrast, brightness, saturation)
	print(hue, contrast, brightness, saturation)

	if hue ~= 0 then
		self._roleAnim:setHue(hue)

		self._hsvChange = true
	end

	if contrast ~= 0 then
		self._roleAnim:setContrast(contrast)

		self._hsvChange = true
	end

	if brightness ~= 0 then
		self._roleAnim:setBrightness(brightness)

		self._hsvChange = true
	end

	if saturation ~= 0 then
		self._roleAnim:setSaturation(saturation)

		self._hsvChange = true
	end
end

function BattleRoleObject:showAtkAndDef(atk, def, hurtrate, unhurtrate)
	if not self._atkdefLabel then
		self._atkdefLabel = cc.Label:createWithTTF(weight, TTF_FONT_FZYH_M, 15)

		self._atkdefLabel:addTo(self:getView()):offset(2, 220)
		self._atkdefLabel:setColor(cc.c3b(255, 0, 0))
	end

	self._atkdefLabel:setString("")

	local desc = "atk:" .. atk .. "\n"
	local desc = desc .. "def:" .. def .. "\n"
	local desc = desc .. "hurtrate:" .. string.format("%0.2f", hurtrate) .. "\n"
	local desc = desc .. "unhurtrate:" .. string.format("%0.2f", unhurtrate)

	self._atkdefLabel:setString(desc)
end

function BattleRoleObject:onTransShap()
	self:cancelThrown()
	self:setRelPosition(self._homePlace)

	self._modelScale = self._dataModel:getModelConfig().Zoom or 1

	self:createHeroAnim()
	self:refreshBuffEffect()
	self:switchState("stand", {
		loop = 1
	})
end
