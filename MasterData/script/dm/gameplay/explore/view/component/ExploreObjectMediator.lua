-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/component/ExploreObjectMediator.lua

ExploreObjectMediator = class("ExploreObjectMediator", DmBaseUI)

ExploreObjectMediator:has("_doing", {
	is = "rw"
})

local moveTimeForPerGrid = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "MapMoveSpeed", "content")
local maxGZOrder = 1999999999
local walk1Tag = 12001
local moveToTag = 12002
local walk2Tag = 12003
local eventTag = 101

function ExploreObjectMediator:initialize(data)
	super.initialize(self)

	self._exploreObject = data
	self._doing = false
	self._speed = 1

	self:initView()

	self._view.mediator = self

	data:setDiffCallBack(function()
		if not tolua.isnull(self._view) then
			self:updateTips()
		end
	end)
	self:updateTips()
end

function ExploreObjectMediator:getExploreObject()
	return self._exploreObject
end

function ExploreObjectMediator:getSprite(node)
	if tolua.type(node) == "cc.Sprite" then
		return node
	end

	local childs = node:getChildren()

	for i = 1, #childs do
		local type = tolua.type(childs[i])

		if tolua.type(node) == "cc.Sprite" then
			return node
		else
			local sp = self:getSprite(childs[i])

			if sp then
				return sp
			end
		end
	end
end

function ExploreObjectMediator:initView()
	local type = self._exploreObject:getResConfigByKey("Type")
	local resName = self._exploreObject:getResConfigByKey("Caseimg")
	local scale = self._exploreObject:getResConfigByKey("Scale") or {
		1,
		1
	}
	local titleName = self._exploreObject:getConfigByKey("Name")
	local ShadeType = self._exploreObject:getResConfigByKey("ShadeType")
	local namePosition = self._exploreObject:getConfigByKey("NamePosition")
	local selectPosition = self._exploreObject:getConfigByKey("SelPosition")
	local ShadeColor = self._exploreObject:getResConfigByKey("ShadeColor") or {}
	local touchSize = self._exploreObject:getResConfigByKey("PicSize") or {
		100,
		100
	}
	local baseNode = cc.GroupedNode:create()
	local viewIsVisible = true
	local node

	if type == 1 then
		node = cc.Sprite:createWithSpriteFrameName(resName .. ".png")

		node:setAnchorPoint(cc.p(0, 0))
	elseif type == 2 then
		node = cc.Node:create()

		node:setContentSize(cc.size(touchSize[1], touchSize[2]))

		local anim = cc.MovieClip:create(resName)

		anim:offset(touchSize[1] / 2, touchSize[2] / 2)
		anim:addTo(node)

		node.anim = anim
		self._isFlash = true
	elseif type == 3 then
		local model = ConfigReader:requireRecordById("RoleModel", resName).Model

		node = RoleFactory:createRoleAnimation(model)
		self._isModel = true
	elseif type == 4 then
		node = cc.Sprite:create("asset/items/" .. resName .. ".png")

		node:setAnchorPoint(cc.p(0, 0))
	elseif type == 5 then
		node = IconFactory:createRoleIconSpriteNew({
			iconType = 2,
			id = resName
		})
	else
		node = cc.Node:create()
		viewIsVisible = false
	end

	if type == 1 or type == 4 or type == 5 then
		if ShadeType == 1 then
			local var_5_0 = self:getSprite(node)

			CustomShaderUtils.setFluxayToNode(rander, cc.c3b(ShadeColor[1] or 255, ShadeColor[2] or 255, ShadeColor[3] or 255))
		end

		if ShadeType == 2 then
			local var_5_1 = self:getSprite(node)

			CustomShaderUtils.setFluxaySuperToNode(rander, cc.c3b(ShadeColor[1] or 255, ShadeColor[2] or 255, ShadeColor[3] or 255))
		end

		if ShadeType == 3 then
			local rander = self:getSprite(node)

			CustomShaderUtils.setDynamicOutlineLightToNode(rander)
			rander:setColor(cc.c3b(ShadeColor[1] or 255, ShadeColor[2] or 255, ShadeColor[3] or 255))
		end
	end

	node:setScale(scale[1], scale[2])

	self._roleScale = scale

	baseNode:addChild(node)

	if titleName then
		::label_5_0::

		local titleStr = Strings:get(titleName)
		local title = cc.Label:createWithTTF(titleStr, CUSTOM_TTF_FONT_1, 18)
		local boundingBox = node:getBoundingBox()

		self._size = cc.size(boundingBox.width, boundingBox.height)

		baseNode:setContentSize(self._size)

		local offsetX = self._size.width * 0.5
		local offsetY = 0

		if namePosition then
			offsetX = namePosition[1]
			offsetY = namePosition[2]
		end

		local bg = ccui.Scale9Sprite:createWithSpriteFrameName("ts_bg_jzname.png", cc.rect(40, 10, 40, 13))
		local titleSize = title:getContentSize()

		bg:setContentSize(cc.size(titleSize.width + 40, titleSize.height + 5))
		title:addTo(bg):center(bg:getContentSize())
		title:offset(0, 3)
		title:enableOutline(cc.c4b(35, 15, 5, 127.5), 2)
		bg:setPosition((type == 2 or type == 3 or nil) and 0, offsetY)
		baseNode:addChild(bg)

		if not titleStr or titleStr == "" then
			bg:setVisible(false)
		end

		if selectPosition then
			local selectPosX = selectPosition[1]
			local selectPosY = selectPosition[2]

			self._selectMarkAnimPos = cc.p(selectPosX, selectPosY)
		end

		local view = cc.Node:create()

		view:addChild(baseNode)
		view:setContentSize(self._size)

		view.realNode = node
		view._baseNode = baseNode
		self._baseNode = baseNode

		self:setView(view)
		self:initDebugBoxes()
		view:setRotation3D(cc.vec3(_G.Explore_3D_degree, 0, 0))
		self:setView(view)
		self:getView():setVisible(viewIsVisible)
	end
end

function ExploreObjectMediator:getBaseNode()
	return self._baseNode
end

function ExploreObjectMediator:setLastCase(lastCaseStr)
	if not self._lastCaseTitle then
		return
	end

	self._lastCaseTitle:setString(lastCaseStr)
end

function ExploreObjectMediator:initDebugBoxes()
	if not _G.isExploreDebug then
		return
	end

	local lastCaseStr = self._exploreObject:getLastCase()
	local title = cc.Label:createWithTTF(lastCaseStr, CUSTOM_TTF_FONT_1, 15)
	local bg = ccui.Scale9Sprite:createWithSpriteFrameName("ts_bg_jzname.png", cc.rect(40, 10, 40, 13))
	local titleSize = title:getContentSize()

	bg:setContentSize(cc.size(titleSize.width + 40, titleSize.height + 5))
	title:addTo(self._view)
	title:enableOutline(cc.c4b(35, 15, 5, 127.5), 2)
	title:setGlobalZOrder(maxGZOrder)

	self._lastCaseTitle = title
	title = cc.Label:createWithTTF(self._exploreObject:getConfigId(), CUSTOM_TTF_FONT_1, 15)

	local bg = ccui.Scale9Sprite:createWithSpriteFrameName("ts_bg_jzname.png", cc.rect(40, 10, 40, 13))
	local titleSize = title:getContentSize()

	bg:setContentSize(cc.size(titleSize.width + 40, titleSize.height + 5))
	title:addTo(self._view)
	title:enableOutline(cc.c4b(35, 15, 5, 127.5), 2)
	title:offset(0, 20)
	title:setGlobalZOrder(maxGZOrder)

	local blockRect = self._exploreObject:getBlockRect()
	local triggerRect = self._exploreObject:getTriggerRect()

	if not blockRect or not triggerRect then
		return
	end

	local anchorPoint = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), 5, 5)

	self._baseNode:addChild(anchorPoint)

	local y = -1 * (blockRect.maxY - self._exploreObject:getY()) * 10
	local x = (blockRect.minX - self._exploreObject:getX()) * 10
	local size = cc.size((blockRect.maxX - blockRect.minX + 1) * 10, (blockRect.maxY - blockRect.minY + 1) * 10)
	local blockLayer = cc.LayerColor:create(cc.c4b(255, 0, 0, 125), size.width, size.height)

	blockLayer:setPosition(x, y)

	y = -1 * (triggerRect.maxY - self._exploreObject:getY()) * 10
	x = (triggerRect.minX - self._exploreObject:getX()) * 10
	size = cc.size((triggerRect.maxX - triggerRect.minX + 1) * 10, (triggerRect.maxY - triggerRect.minY + 1) * 10)

	local triggerLayer = cc.LayerColor:create(cc.c4b(0, 255, 0, 125), size.width, size.height)

	triggerLayer:setPosition(x, y)
	self._baseNode:addChild(triggerLayer)
	self._baseNode:addChild(blockLayer)
end

function ExploreObjectMediator:updateTips()
	local tips = self._exploreObject:getTips()

	if self._tipsIcon then
		self._tipsIcon:removeFromParent(true)

		self._tipsIcon = nil
	end

	if tips and tips ~= "" then
		local posInfo = self._exploreObject:getConfigByKey("TipsPicPosition")
		local tipsIcon = ccui.Scale9Sprite:createWithSpriteFrameName("liaotian_bg_qipao_1_common.png", cc.rect(27, 15, 27, 13))

		tipsIcon:setContentSize(cc.size(80, 60))

		local iconSprite = cc.Sprite:create(string.format("asset/exploreTipsIcon/%s.png", tips))

		iconSprite:addTo(tipsIcon):center(tipsIcon:getContentSize())
		tipsIcon:setPosition(posInfo[1], posInfo[2])

		local groupedNode = cc.GroupedNode:create()

		groupedNode:addChild(tipsIcon)
		self._view:addChild(groupedNode)

		self._tipsIcon = groupedNode

		self._tipsIcon:setGlobalZOrder(maxGZOrder)
	end
end

function ExploreObjectMediator:initTalkView()
	if self._talkView then
		return
	end

	local talkView = self:getInjector():getInstance("ExploreTalkView")

	self._talkLabel = talkView:getChildByName("Text_1")

	self._talkLabel:getVirtualRenderer():setMaxLineWidth(120)

	self._talkBg = talkView:getChildByName("bg")

	local posInfo = self._exploreObject:getConfigByKey("TipsPicPosition")
	local pos = {
		0,
		self._size.height
	}

	if posInfo then
		pos = posInfo
	end

	talkView:setPosition(pos[1] - 25, pos[2] - 32)

	local groupedNode = cc.GroupedNode:create()

	groupedNode:addChild(talkView)
	self._view:addChild(groupedNode)

	self._talkView = groupedNode

	self._talkView:setGlobalZOrder(maxGZOrder)
	self._talkView:setVisible(false)
end

function ExploreObjectMediator:showDialogue(info, callback)
	self:initTalkView()
	self._talkView:setVisible(true)
	self._talkLabel:setString(Strings:get(info.TalkDes))

	local lableSize = self._talkLabel:getContentSize()

	self._talkBg:setContentSize(cc.size(lableSize.width + 20, lableSize.height + 25))

	local delay = cc.DelayTime:create(info.Time)
	local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
		self._talkView:setVisible(false)

		if self._eventAction then
			self._eventAction = nil

			callback()
		end
	end))

	sequence:setTag(eventTag)

	self._eventAction = sequence

	self:getView():runAction(sequence)
end

function ExploreObjectMediator:stopAnimation()
	if not self._isModel then
		return
	end

	self._view.realNode:stopAnimation()
end

function ExploreObjectMediator:playAnimation(name, times, endActionName)
	if not self._isModel then
		return
	end

	times = times or -1

	CommonUtils.playSpineByTimes(self._view.realNode, times, name, function()
		if endActionName then
			self._view.realNode:playAnimation(0, endActionName, true)
		end
	end)
end

function ExploreObjectMediator:addEffect(info, callback)
	local pos = cc.p(info.Position[1], info.Position[2])
	local anim = cc.MovieClip:create(info.NameID)

	anim:setPosition(pos)
	anim:addTo(self._baseNode)

	if not info.Num then
		local num = 1
		local number = num > 0 and num or math.huge

		if number > 0 and number < math.huge then
			performWithDelay(anim, function()
				if callback then
					callback()
				end

				anim:removeFromParent(true)
			end, number / 30)
		elseif callback then
			callback()
		end
	end
end

function ExploreObjectMediator:playAddAction(actionAttachNode)
	local action = self._exploreObject:getConfigByKey("BornAction")
	local effect = self._exploreObject:getConfigByKey("BornEffect") or {}
	local beforeEffect = effect.Before
	local afterEffect = effect.After

	if beforeEffect then
		self:addEffect(beforeEffect)
	end

	self:playActionByInfo(action, actionAttachNode, function()
		if afterEffect then
			self:addEffect(afterEffect)
		end
	end)
end

function ExploreObjectMediator:playActionByInfo(info, actionAttachNode, callback)
	if not info then
		callback()

		return
	end

	local type = tonumber(info.Type)

	if type == 1 then
		local pos = actionAttachNode:convertToNodeSpace(self._view:getParent():convertToWorldSpace(cc.p(self._view:getPosition())))

		self._view:changeParent(actionAttachNode)
		self._view:setPosition(pos)

		local length = cc.pGetLength(pos)
		local time = length / info.Speed
		local action = cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(time, cc.p(0, 60)), cc.ScaleTo:create(time, 0)), cc.CallFunc:create(function()
			if callback then
				callback()
			end
		end))

		self._view:runAction(action)
	elseif type == 2 then
		local height = tonumber(info.High) or 200

		self._view:offset(0, height)

		local time = height / (info.Speed or 10 * height + 1)
		local action = cc.Sequence:create(cc.EaseIn:create(cc.MoveBy:create(time, cc.p(0, -1 * height)), 3), cc.CallFunc:create(function()
			if callback then
				callback()
			end
		end))

		self._view:runAction(action)
	elseif callback then
		callback()
	end
end

function ExploreObjectMediator:playRemoveAction(actionAttachNode, callback)
	local action = self._exploreObject:getConfigByKey("DieAction")
	local effect = self._exploreObject:getConfigByKey("DieEffect") or {}
	local beforeEffect = effect.Before
	local afterEffect = effect.After

	if beforeEffect then
		local cb

		self:addEffect(beforeEffect, (not action or nil) and callback)
	elseif not action then
		callback()

		return
	end

	if not action then
		return
	end

	self:playActionByInfo(action, actionAttachNode, function()
		if afterEffect then
			self:addEffect(afterEffect, callback)
		else
			callback()

			return
		end
	end)
end

function ExploreObjectMediator:setRoleTurn(isLeft)
	if not self._isModel then
		return
	end

	local scale = math.abs(self._roleScale[1])

	if isLeft then
		self._view.realNode:setScaleX(-1 * scale)
	else
		self._view.realNode:setScaleX(scale)
	end
end

function ExploreObjectMediator:setSkeletonAnimationGroup(skeletonAnimGroup)
	if not self._isModel then
		return
	end

	self._view.realNode:setSkeletonAnimationGroup(skeletonAnimGroup)
end

function ExploreObjectMediator:initProgressView()
	if self._progressView then
		return
	end

	local progressView = self:getInjector():getInstance("ExploreRewardBar")

	progressView:setAnchorPoint(0.5, 0)
	progressView:setIgnoreAnchorPointForPosition(false)

	self._progressLabel = progressView:getChildByName("Text_1")

	local bg = progressView:getChildByName("Image_bg")
	local scale = self._size.width / bg:getContentSize().width

	bg:setScaleX(scale)

	self._loadingBar = progressView:getChildByName("LoadingBar")

	self._loadingBar:setScaleX(scale)
	progressView:setPosition(self._size.width * 0.5, 50)

	local groupedNode = cc.GroupedNode:create()

	groupedNode:addChild(progressView)
	groupedNode:setGlobalZOrder(maxGZOrder)
	self._view:addChild(groupedNode)

	self._progressView = groupedNode

	self._progressView:setVisible(false)
end

function ExploreObjectMediator:showProgressBar(info, callback)
	self:initProgressView()
	self._loadingBar:setPercent(0)
	self._progressView:setVisible(true)
	self._progressLabel:setString(Strings:get(info.desc))

	local num = math.floor(info.time * 10)
	local delay = cc.DelayTime:create(0.1)
	local index = 0
	local sequence = cc.Sequence:create(delay, cc.CallFunc:create(function()
		index = index + 1

		if index > num then
			self._progressView:setVisible(false)

			if self._eventAction then
				self._eventAction = nil

				callback()
			end

			return
		end

		self._loadingBar:setPercent(index * 100 / num)
	end))
	local action = cc.Repeat:create(sequence, num + 1)

	action:setTag(eventTag)

	self._eventAction = action

	self:getView():runAction(action)
end

function ExploreObjectMediator:cleanEvent()
	self:setDoing(false)

	if self._progressView then
		self._progressView:setVisible(false)
	end

	if self._talkView then
		self._talkView:setVisible(false)
	end

	self._eventAction = nil

	self:getView():stopActionByTag(eventTag)
end

function ExploreObjectMediator:setSelectStatus(select)
	if tolua.isnull(self._view) then
		return
	end

	if not self._selectMarkAnimPos then
		return
	end

	if not self._selectMarkAnim then
		local anim = cc.MovieClip:create("jiantou_wupinxuanzhongzhuangtai")

		anim:setName("SelectMark")
		anim:setPosition(self._selectMarkAnimPos)

		local groupedNode = cc.GroupedNode:create()

		groupedNode:addChild(anim)
		self._view:addChild(groupedNode)

		self._selectMarkAnim = groupedNode

		self._selectMarkAnim:setVisible(false)
		self._selectMarkAnim:setGlobalZOrder(maxGZOrder)
	end

	self._selectMarkAnim:setVisible(select)
end

function ExploreObjectMediator:initWalk()
	local data = self._exploreObject:getConfigByKey("Walk")

	if not data or not data.Type then
		return
	end

	self._speed = data.Speed or moveTimeForPerGrid
	self._waitTime = data.Time or 0

	local type = data.Type
	local currentPos = {
		x = self._view:getPositionX(),
		y = self._view:getPositionY()
	}

	if type == "1" then
		local radius = data.Radius
		local length = math.sqrt(radius * radius / 2)

		self._posArr = {
			cc.p(currentPos.x, currentPos.y),
			cc.p(currentPos.x - radius, currentPos.y),
			cc.p(currentPos.x + radius, currentPos.y),
			cc.p(currentPos.x, currentPos.y + radius),
			cc.p(currentPos.x, currentPos.y - radius),
			cc.p(currentPos.x + length, currentPos.y + length),
			cc.p(currentPos.x + length, currentPos.y - length),
			cc.p(currentPos.x - length, currentPos.y + length),
			cc.p(currentPos.x - length, currentPos.y - length)
		}
		self._randomPos1 = nil
		self._randomPos2 = nil

		self:runWalkAction1()
	elseif type == "2" then
		self._cycleNum = data.Num or -1
		self._curCycleNum = 0
		self._currentIndex = 0
		self._currentIndexRate = 1
		self._cycleRoute = data.Route
		self._posArr = {}

		for i = 1, #self._cycleRoute do
			local offsetX = self._cycleRoute[i][1]
			local offsetY = self._cycleRoute[i][2]

			if not self._posArr[i - 1] then
				local prePos = currentPos
				local pos = cc.p(prePos.x + offsetX, prePos.y - offsetY)

				table.insert(self._posArr, pos)
			end
		end

		self:runWalkAction2()
	end
end

function ExploreObjectMediator:runWalkAction1()
	if self._view:getActionByTag(walk1Tag) then
		return
	end

	self._view:stopActionByTag(walk1Tag)
	self._view:stopActionByTag(moveToTag)

	local delay = math.random(0, 10)

	performWithDelay(self._view, function()
		local callback = cc.CallFunc:create(function()
			local targetPos = self:getRandomWalkPos()

			self:moveToTargetPos(targetPos, self._speed)
		end)
		local delay1 = cc.DelayTime:create(self._speed)
		local callback1 = cc.CallFunc:create(function()
			self:playAnimation("stand")
		end)
		local delay = cc.DelayTime:create(self._waitTime)
		local sequence = cc.Sequence:create(callback, delay1, callback1, delay)
		local action = cc.RepeatForever:create(sequence)

		action:setTag(walk1Tag)
		self._view:runAction(action)
	end, delay / 10)
end

function ExploreObjectMediator:getRandomWalkPos()
	if #self._posArr == 9 then
		local index = math.random(1, 9)

		self._randomPos1 = table.remove(self._posArr, index)

		return self._randomPos1
	end

	if not self._randomPos2 then
		local index = math.random(1, 8)

		self._randomPos2 = table.remove(self._posArr, index)

		table.insert(self._posArr, self._randomPos1)

		return self._randomPos2
	end

	local index = math.random(1, 8)

	self._randomPos1 = table.remove(self._posArr, index)

	table.insert(self._posArr, self._randomPos2)

	self._randomPos2 = nil

	return self._randomPos1
end

function ExploreObjectMediator:runWalkAction2()
	if #self._cycleRoute < 2 then
		return
	end

	if self._view:getActionByTag(walk2Tag) then
		return
	end

	self._view:stopActionByTag(walk2Tag)
	self._view:stopActionByTag(moveToTag)

	local animCallback = self._cycleNum == -1 and function()
		local callback = cc.CallFunc:create(function()
			local targetPos = self:getDefaultWalkPos()

			self:moveToTargetPos(targetPos, self._speed)
		end)
		local delay1 = cc.DelayTime:create(self._speed)
		local callback1 = cc.CallFunc:create(function()
			self:playAnimation("stand")
		end)
		local delay = cc.DelayTime:create(self._waitTime)
		local sequence = cc.Sequence:create(callback, delay1, callback1, delay)
		local action = cc.RepeatForever:create(sequence)

		action:setTag(walk2Tag)
		self._view:runAction(action)
	end or function()
		local callback = cc.CallFunc:create(function()
			if self._curCycleNum > self._cycleNum then
				self._view:stopActionByTag(walk2Tag)

				return
			end

			local targetPos = self:getDefaultWalkPos()

			self:moveToTargetPos(targetPos, self._speed)
		end)
		local delay1 = cc.DelayTime:create(self._speed)
		local callback1 = cc.CallFunc:create(function()
			self:playAnimation("stand")
		end)
		local delay = cc.DelayTime:create(self._waitTime)
		local sequence = cc.Sequence:create(callback, delay1, callback1, delay)
		local action = cc.RepeatForever:create(sequence)

		action:setTag(walk2Tag)
		self._view:runAction(action)
	end
	local delay = math.random(0, 10)

	performWithDelay(self._view, function()
		if animCallback then
			animCallback()
		end
	end, delay / 10)
end

function ExploreObjectMediator:getDefaultWalkPos()
	self._currentIndex = self._currentIndex + self._currentIndexRate

	if self._currentIndex == #self._posArr then
		self._currentIndexRate = -1
	elseif self._currentIndex == 1 then
		self._currentIndexRate = 1
	end

	if self._currentIndex == 1 then
		self._curCycleNum = self._curCycleNum + 1
	end

	return self._posArr[self._currentIndex]
end

function ExploreObjectMediator:runWalkAction3(data, zOrderCallback)
	if not data.Walk then
		self._view:removeFromParent()

		return
	end

	data = data.Walk

	if not data.Speed then
		local speed = moveTimeForPerGrid

		if not data.Time then
			local waitTime = 0
			local currentPos = {
				x = self._view:getPositionX(),
				y = self._view:getPositionY()
			}
			local cycleRoute = data.Route
			local posArr = {}

			for i = 1, #cycleRoute do
				local offsetX = cycleRoute[i][1]
				local offsetY = cycleRoute[i][2]

				if not posArr[i - 1] then
					local prePos = currentPos
					local pos = cc.p(prePos.x + offsetX, prePos.y - offsetY)

					table.insert(posArr, pos)
				end
			end

			local function getNextPos()
				return (table.remove(posArr, 1))
			end

			local callback = cc.CallFunc:create(function()
				local targetPos = getNextPos()

				if not targetPos then
					self._view:stopAllActions()
					self:runFadeOutAction()

					return
				end

				self:moveToTargetPos(targetPos, speed)
			end)
			local delay1 = cc.DelayTime:create(speed)
			local callback1 = cc.CallFunc:create(function()
				self:playAnimation("stand")
			end)
			local delay = cc.DelayTime:create(waitTime)
			local sequence = cc.Sequence:create(callback, delay1, callback1, delay)
			local spawn = cc.Spawn:create(sequence, cc.CallFunc:create(function()
				schedule(self._view, function()
					zOrderCallback()
				end, 0.1)
			end))
			local action = cc.RepeatForever:create(spawn)

			self._view:runAction(action)
		end
	end
end

function ExploreObjectMediator:runFadeOutAction()
	local fadeOut = cc.FadeOut:create(0.3)
	local callback = cc.CallFunc:create(function()
		self._view:removeFromParent()
	end)
	local sequence = cc.Sequence:create(fadeOut, callback)

	self._view:runAction(sequence)
end

function ExploreObjectMediator:moveToTargetPos(pos, time)
	self:playAnimation("run")

	if pos.x > self._view:getPositionX() then
		self:setRoleTurn(false)
	elseif pos.x < self._view:getPositionX() then
		self:setRoleTurn(true)
	end

	local move1 = cc.MoveTo:create(time, pos)

	move1:setTag(moveToTag)
	self._view:runAction(move1)
end

function ExploreObjectMediator:stopWalkActions()
	local data = self._exploreObject:getConfigByKey("Walk")

	if not data or not data.Type then
		return
	end

	if data.Stop and data.Stop == 1 then
		self:playAnimation("stand")
		self._view:stopActionByTag(walk1Tag)
		self._view:stopActionByTag(walk2Tag)
		self._view:stopActionByTag(moveToTag)
	end
end

function ExploreObjectMediator:resumeWalkAction()
	if tolua.isnull(self._view) then
		return
	end

	local data = self._exploreObject:getConfigByKey("Walk")

	if not data or not data.Type then
		return
	end

	local type = data.Type

	if type == "1" then
		self:runWalkAction1()
	elseif type == "2" then
		self:runWalkAction2()
	end
end
