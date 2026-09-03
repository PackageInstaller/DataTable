-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/component/PetRaceFinalEightLayer.lua

PetRaceFinalEightLayer = class("PetRaceFinalEightLayer", DmBaseUI)

PetRaceFinalEightLayer:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

local kBtnHandlers = {}
local desRoundInfo = {
	Strings:get("Petrace_Text_19"),
	Strings:get("Petrace_Text_20"),
	Strings:get("Petrace_Text_21")
}

function PetRaceFinalEightLayer:initialize(data)
	super.initialize(self)

	self._allList = {}
	self._reportList = {}

	self:setView(data.view)
	self:intiView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function PetRaceFinalEightLayer:intiView()
	AdjustUtils.adjustLayoutUIByRootNode(self:getView())

	local function viewReport(buttonIndex)
		local round = 11

		if buttonIndex > 4 and buttonIndex < 7 then
			round = 12
		elseif buttonIndex == 7 then
			round = 13
		end

		local isRigist = self._petRaceSystem:isRegist()
		local roundNow = self._petRaceSystem:getRound()

		if isRigist then
			local var_3_0 = self._petRaceSystem:getMyMatchState()

			if not var_3_0 then
				var_3_0 = self._petRaceSystem:getCurMatchState()

				local state = var_3_0

				if round <= roundNow then
					local reportid = self._reportList[buttonIndex]

					if round == roundNow and state ~= PetRaceEnum.state.match and state ~= PetRaceEnum.state.matchOver then
						AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
						self:showTip(Strings:get("Petrace_Text_2"))
					elseif reportid and #reportid > 0 then
						self._petRaceSystem:requestReportDetail(round, reportid, true)
					else
						AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
						self:showTip(Strings:get("Petrace_Text_50"))
					end
				else
					AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
					self:showTip(Strings:get("Petrace_Text_2"))
				end
			end
		end
	end

	for i = 1, 7 do
		local buttonkey = self:getView():getChildByFullName("Panel_base.Button_View_" .. i)

		self:mapButtonHandlerClick(buttonkey, function()
			viewReport(i)
		end)
	end

	for i = 1, 15 do
		local index = i
		local nodeB = self:getView():getChildByFullName("Panel_base.Node_role_" .. index)
		local node = nodeB:getChildByFullName("Node_1")
		local btn = node:getChildByFullName("Button")

		btn:setVisible(true)
		btn:addClickEventListener(function()
			self:onClickHeroIcon(index)
		end)
	end
end

function PetRaceFinalEightLayer:showTip(str)
	self:dispatch(ShowTipEvent({
		duration = 0.5,
		tip = str
	}))
end

function PetRaceFinalEightLayer:getRoleIcon(headId)
	return (IconFactory:createPetRaceHeadImage({
		id = headId
	}))
end

function PetRaceFinalEightLayer:initFinalHeroIconInfo(index)
	local heroInfo = self._allList[index]
	local heroData = heroInfo.info
	local winSta = heroInfo.win
	local heroNode = self:getView():getChildByFullName("Panel_base.Node_role_" .. index)
	local node_own = heroNode:getChildByFullName("Node_1")
	local node_none = self:getView():getChildByFullName("Panel_base.Image_none_" .. index)

	node_own:setVisible(false)
	node_none:setVisible(false)

	local winLine = self:getView():getChildByFullName("Panel_base.Node_line.Image_line" .. index)

	if winLine then
		winLine:setVisible(false)
	end

	if heroData then
		node_own:setVisible(true)

		local node_head = node_own:getChildByName("Node_head")

		node_head:setScale(1)

		local node_sta = node_own:getChildByFullName("Node_win")
		local heroIcon = node_head:getChildByTag(101)

		if not heroIcon then
			heroIcon = self:getRoleIcon(heroData.headImg)

			heroIcon:setTag(101)
			node_head:addChild(heroIcon)
			heroIcon:setPosition(cc.p(0, -9))

			local power_text = node_own:getChildByName("Text_power")

			power_text:setString(heroData.combat or "")

			local name_text = node_own:getChildByName("Text_name")

			name_text:setString(heroData.nickname)
		end

		if winLine and winSta == true then
			winLine:setVisible(winSta)
		end

		node_sta:setVisible(false)

		local node_win = node_sta:getChildByFullName("Node_win")
		local node_best = node_sta:getChildByFullName("Node_best")

		if index == 15 then
			node_sta:setVisible(true)
			node_best:setVisible(true)
		elseif winSta == true then
			node_sta:setVisible(true)
			node_win:setVisible(true)
		end

		if winSta == true then
			heroNode:setGray(false)
		elseif winSta == false then
			heroNode:setGray(true)
		end
	else
		node_none:setVisible(true)
	end
end

function PetRaceFinalEightLayer:updateFinalHeroIconInfo()
	local finalEightInfo = self._petRaceSystem:getFinalVO() or {}

	if not finalEightInfo.userList then
		local userList = {}

		if not finalEightInfo.roundList then
			local roundList = {}
			local round = self._petRaceSystem:getRound()
			local isRigist = self._petRaceSystem:isRegist()

			if isRigist then
				local var_9_2 = self._petRaceSystem:getMyMatchState()

				if not var_9_2 then
					var_9_2 = self._petRaceSystem:getCurMatchState()

					local state = var_9_2

					local function getWinSta(roundIndex, rid)
						local winSta, reportId

						for k, v in pairs(roundList) do
							if round == roundIndex and state ~= PetRaceEnum.state.match and state ~= PetRaceEnum.state.matchOver then
								-- block empty
							elseif v.round == roundIndex then
								if v.winId == rid then
									reportId = v.reportId or ""

									return true, reportId
								end

								winSta = false
							end
						end

						return winSta, reportId
					end

					local function getNextIndex(index)
						local finalIndex = 0
						local reportIndex = 0

						if index == 1 or index == 2 then
							finalIndex = 9
							reportIndex = 1
						elseif index == 3 or index == 4 then
							finalIndex = 10
							reportIndex = 2
						elseif index == 5 or index == 6 then
							finalIndex = 11
							reportIndex = 3
						elseif index == 7 or index == 8 then
							finalIndex = 12
							reportIndex = 4
						elseif index == 9 or index == 10 then
							finalIndex = 13
							reportIndex = 5
						elseif index == 11 or index == 12 then
							finalIndex = 14
							reportIndex = 6
						elseif index == 13 or index == 14 then
							finalIndex = 15
							reportIndex = 7
						end

						return finalIndex, reportIndex
					end

					self._allList = {}
					self._reportList = {}

					for k, v in pairs(userList) do
						local finalIndex = v.finalIndex

						if finalIndex then
							self._allList[finalIndex] = self._allList[finalIndex] or {}
							self._allList[finalIndex].info = v

							local winSta_, reportId_ = getWinSta(11, v.rid)

							self._allList[finalIndex].win = winSta_

							if winSta_ == true then
								local index_11, reoprtIndex_11 = getNextIndex(finalIndex)

								if index_11 ~= 0 then
									self._reportList[reoprtIndex_11] = reportId_
									self._allList[index_11] = self._allList[index_11] or {}
									self._allList[index_11].info = v

									local winSta__, reportId__ = getWinSta(12, v.rid)

									self._allList[index_11].win = winSta__

									if winSta__ == true then
										local index_12, reoprtIndex_12 = getNextIndex(index_11)

										if index_12 ~= 0 then
											self._reportList[reoprtIndex_12] = reportId__
											self._allList[index_12] = self._allList[index_12] or {}
											self._allList[index_12].info = v

											local winSta___, reportId___ = getWinSta(13, v.rid)

											self._allList[index_12].win = winSta___

											if winSta___ == true then
												local index_13, reoprtIndex_13 = getNextIndex(index_12)

												self._allList[index_13] = self._allList[index_13] or {}
												self._allList[index_13].info = v
												self._reportList[reoprtIndex_13] = reportId___
											end
										end
									end
								end
							end
						end
					end

					for i = 1, 15 do
						self._allList[i] = self._allList[i] or {}
					end

					for k, v in pairs(self._allList) do
						self:initFinalHeroIconInfo(k)
					end
				end
			end
		end
	end
end

function PetRaceFinalEightLayer:onClickHeroIcon(index)
	if self._allList[index] then
		local heroInfo = self._allList[index].info

		if heroInfo then
			local data = {}

			data.dataInfo = heroInfo
			data.clickIndex = index

			local view = self:getInjector():getInstance("PetRaceSquadView")
			local event = ViewEvent:new(EVT_SHOW_POPUP, view, {}, data)

			self:dispatch(event)
		end
	end
end

function PetRaceFinalEightLayer:updateTime()
	local node_time = self:getView():getChildByFullName("Panel_base.Node_time")

	self._petRaceSystem:updateTimeDes(node_time)
end

function PetRaceFinalEightLayer:refreshView()
	self:updateFinalHeroIconInfo()
end
