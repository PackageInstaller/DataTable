-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/component/ExploreRoleMediator.lua

ExploreRoleMediator = class("ExploreRoleMediator", DmBaseUI)

local maxGZOrder = 1999999999
local eventTag = 101

function ExploreRoleMediator:initialize(id)
	super.initialize(self)

	self._id = ConfigReader:getRecordById("RoleModel", id).Model
	self._roleScale = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MapMasterScale", "content") or 0.5

	self:initView()

	self._view.mediator = self
end

function ExploreRoleMediator:initView()
	local baseNode = cc.GroupedNode:create()
	local node = RoleFactory:createRoleAnimation(self._id)

	node:setScale(self._roleScale)
	baseNode:addChild(node)

	local boundingBox = node:getBoundingBox()

	self._size = cc.size(boundingBox.width, boundingBox.height)

	baseNode:setContentSize(self._size)

	local view = cc.Node:create()

	view:addChild(baseNode)
	view:setContentSize(self._size)

	view.realNode = node
	view._baseNode = baseNode
	self._baseNode = baseNode

	view:setRotation3D(cc.vec3(_G.Explore_3D_degree, 0, 0))
	self:setView(view)
end

function ExploreRoleMediator:getBaseNode()
	return self._baseNode
end

function ExploreRoleMediator:initTalkView()
	if self._talkView then
		return
	end

	local talkView = self:getInjector():getInstance("ExploreTalkView")

	self._talkLabel = talkView:getChildByName("Text_1")

	self._talkLabel:getVirtualRenderer():setMaxLineWidth(120)

	self._talkBg = talkView:getChildByName("bg")

	talkView:setPosition(0, self._size.height)

	local groupedNode = cc.GroupedNode:create()

	groupedNode:addChild(talkView)
	self._view:addChild(groupedNode)

	self._talkView = groupedNode

	self._talkView:setGlobalZOrder(maxGZOrder)
	self._talkView:setVisible(false)
end

function ExploreRoleMediator:showDialogue(info, callback)
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

function ExploreRoleMediator:stopAnimation()
	self._view.realNode:stopAnimation()
end

function ExploreRoleMediator:playAnimation(name, times, endActionName, callback)
	times = times or -1

	CommonUtils.playSpineByTimes(self._view.realNode, times, name, function()
		if endActionName then
			self._view.realNode:playAnimation(0, endActionName, true)
		end

		if callback then
			callback()
		end
	end)
end

function ExploreRoleMediator:setRoleTurn(isLeft)
	if isLeft then
		self._view.realNode:setScaleX(-1 * self._roleScale)
	else
		self._view.realNode:setScaleX(self._roleScale)
	end
end

function ExploreRoleMediator:setSkeletonAnimationGroup(skeletonAnimGroup)
	self._view.realNode:setSkeletonAnimationGroup(skeletonAnimGroup)
end

function ExploreRoleMediator:cleanEvent()
	self:getView():stopActionByTag(eventTag)

	if self._talkView then
		self._talkView:setVisible(false)
	end

	self._eventAction = nil
end

function ExploreRoleMediator:addEffect(info)
	local pos = cc.p(info.Position[1], info.Position[2])
	local anim = cc.MovieClip:create(info.NameID)

	anim:setPosition(pos)
	anim:addTo(self._baseNode)

	if info.Num > 0 then
		if not info.Num then
			local number = math.huge

			if number > 0 and number < math.huge then
				performWithDelay(anim, function()
					anim:removeFromParent(true)
				end, number / 30)
			end
		end
	end
end
