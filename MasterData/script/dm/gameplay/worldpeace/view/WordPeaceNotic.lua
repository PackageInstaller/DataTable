-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WordPeaceNotic.lua

WordPeaceNotic = class("WordPeaceNotic", BaseWidget, _M)

WordPeaceNotic:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")

function WordPeaceNotic:initialize(view)
	super.initialize(self, view)
	view:setOpacity(0)

	self._massages = {}
end

function WordPeaceNotic:dispose()
	if self._flowTask then
		self._flowTask:stop()

		self._flowTask = nil
	end

	local view = self._view

	if view then
		view:removeFromParent()

		self._view = nil
	end

	super.dispose(self)
end

function WordPeaceNotic:setGroupMap(groupNameMap)
	self._groupNameMap = groupNameMap
end

function WordPeaceNotic:addMessage(message)
	self._massages[#self._massages + 1] = message
end

function WordPeaceNotic:start()
	local view = self:getView()
	local layout = view:getChildByName("layout")
	local layoutSize = layout:getContentSize()

	layout:setSwallowTouches(false)

	local speed = 100
	local isRunning = false
	local isVisible = false
	local index = 1

	local function playFlow()
		if isRunning then
			return
		end

		view:setVisible(true)

		if self._message == nil then
			self._message = table.remove(self._massages, 1)

			if self._message == nil then
				if isVisible then
					isRunning = true

					local fadeOutAct = cc.FadeOut:create(0.3)
					local callFuncAct = cc.CallFunc:create(function()
						isRunning = false
						isVisible = false
					end)
					local action = cc.Sequence:create(fadeOutAct, callFuncAct)

					view:runAction(action)
				end

				return
			end
		end

		isRunning = true

		local times = 1

		local function flowFunc()
			local messageView = self:createContent(self._message)

			messageView:setAnchorPoint(0, 0.5)
			messageView:addTo(layout):posite(layoutSize.width, layoutSize.height * 0.5 - 10)

			local messageViewSize = messageView:getContentSize()
			local moveDistance = math.max(messageViewSize.width, layoutSize.width)
			local moveByAction = cc.MoveBy:create(moveDistance / speed, cc.p(-moveDistance, 0))
			local delayTimeAct = cc.DelayTime:create(1)
			local fadeOutAct = cc.FadeOut:create(0.4)
			local callFuncAct = cc.CallFunc:create(function()
				isRunning = false

				if index >= times then
					self._message = nil
					index = 1
				else
					index = index + 1
				end

				messageView:removeFromParent()
			end)
			local action = cc.Sequence:create(moveByAction, delayTimeAct, fadeOutAct, callFuncAct)

			messageView:runAction(action)
		end

		if not isVisible then
			local fadeInAct = cc.FadeIn:create(0.3)
			local callFuncAct = cc.CallFunc:create(function()
				isVisible = true

				flowFunc()
			end)
			local action = cc.Sequence:create(fadeInAct, callFuncAct)

			view:runAction(action)
		else
			flowFunc()
		end
	end

	self._flowTask = LuaScheduler:getInstance():schedule(playFlow, 1, true)
end

function WordPeaceNotic:createContent(log)
	local playerInfo = self._worldPeaceSystem:getMainPlayer()
	local battleField = self._worldPeaceSystem:getBattlefield()
	local groupNameMap = battleField:getGroupNameMap()
	local bossData = battleField:getBossById(log.bossId)
	local heroCfg = ConfigReader:getRecordById("HeroBase", bossData:getConfig().Hero)
	local v = log
	local color = {
		"#fd62ff",
		"#ffe26e",
		"#81cdff"
	}

	for k_, v_ in pairs(groupNameMap) do
		if v.campId == v_.gId then
			gIndex = v_.gIndex
		end
	end

	local gorupInfo = playerInfo:getGroupInfo()
	local richText, newCamp

	for k_, v_ in pairs(groupNameMap) do
		if v.campId == v_.gId then
			gIndex = v_.gIndex
			newCamp = v_.gName
		end
	end

	local time = TimeUtil:localDate("%Y-%m-%d %H:%M:%S", v.time / 1000)
	local oldCampInfo = self._worldPeaceSystem:getCampInfo(v.oldCampId)
	local newCampInfo = self._worldPeaceSystem:getCampInfo(v.campId)
	local gIndex = 1

	for k_, v_ in pairs(groupNameMap) do
		if v.params.camp and v.params.camp == v_.gName then
			gIndex = v_.gIndex
		end
	end

	local color = color[gIndex]
	local reason
	local campName
	local player
	local strformat = Strings:get("ClubMapBoss_Announce" .. v.type, {
		fontSize = 16,
		fontName = TTF_FONT_FZYH_M,
		time = time,
		camp = (v.params and v.params.camp or nil) and v.params.camp,
		bossname = Strings:get(heroCfg.Name),
		num = bossData:getLv(),
		color = color,
		reason = (v.params and v.params.reason or nil) and Strings:get("ClubMapBoss_Announce5_reason" .. v.params.reason),
		player = (v.params and v.params.player or nil) and v.params.player
	})
	local richText = ccui.RichText:createWithXML(strformat, {})
	local item = ccui.Layout:create()

	richText:setAnchorPoint(cc.p(0, 0))
	richText:setPosition(cc.p(0, 0))
	richText:addTo(item)
	item:setContentSize(richText:getContentSize().width + 1200, richText:getContentSize().height)

	return item
end
