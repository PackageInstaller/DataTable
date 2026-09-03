-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/LoginActivityMediator.lua

LoginActivityMediator = class("LoginActivityMediator", DmPopupViewMediator, _M)

LoginActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local actUIConfig = {
	Login_Holiday = {
		bgPath = "asset/scene/shuangdan_img_14qd_ljdl.jpg",
		cellTitle = "shuangdan_btn_14qd_ldi.png",
		title = {
			img = "shuangdan_img_14qd_biaoti.png",
			textFontSize = 48,
			size = cc.size(461, 118),
			offset = {
				10,
				0
			},
			textOffset = {
				50,
				-3
			},
			textPattern = {
				cc.c4b(255, 245, 175, 255),
				cc.c4b(255, 224, 115, 255)
			},
			textOutline = {
				size = 1,
				color = cc.c4b(211, 72, 76, 255)
			}
		},
		desc = {
			color = cc.c3b(255, 242, 99),
			offset = {
				-60,
				-10
			}
		},
		cellBg = {
			"shuangdan_btn_14qd_ldj.png",
			"shuangdan_btn_14qd_ld_j.png",
			"shuangdan_btn_14qd_ld_wxz.png",
			"shuangdan_btn_14qd_ld_xz.png",
			"shuangdan_btn_14qd_ld_ylq.png"
		}
	},
	Login_Detective = {
		bgPath = "asset/scene/ywzjdzx_img_14qd_ljdl.jpg",
		cellTitle = "ywzjdzx_btn_14qd_ldi.png",
		title = {
			img = "ywzjdzx_img_14qd_biaoti.png",
			textFontSize = 36,
			size = cc.size(572, 102),
			offset = {
				10,
				0
			},
			textOffset = {
				-35,
				13
			},
			color = cc.c3b(255, 255, 255),
			textOutline = {
				size = 1,
				color = cc.c4b(0, 0, 0, 255)
			},
			textshadow = {
				width = 1,
				color = cc.c4b(0, 0, 0, 90),
				size = cc.size(0, -2)
			}
		},
		desc = {
			color = cc.c3b(255, 241, 208),
			offset = {
				-65,
				45
			},
			textOutline = {
				size = 1,
				color = cc.c4b(0, 0, 0, 255)
			}
		},
		cellBg = {
			"ywzjdzx_btn_14qd_ldj.png",
			"ywzjdzx_btn_14qd_ld_j.png",
			"ywzjdzx_btn_14qd_ld_wxz.png",
			"ywzjdzx_btn_14qd_ld_xz.png",
			"ywzjdzx_btn_14qd_ld_ylq.png"
		}
	},
	Login_Music = {
		bgPath = "asset/scene/musicfestival_img_14qd_ljdl.jpg",
		cellTitle = "musicfestival_btn_14qd_ldi.png",
		title = {
			img = "musicfestival_img_14qd_biaoti.png",
			textFontSize = 36,
			size = cc.size(617, 139),
			offset = {
				66,
				-14
			},
			textOffset = {
				-2,
				-14
			},
			color = cc.c3b(255, 255, 255),
			textOutline = {
				size = 1,
				color = cc.c4b(0, 0, 0, 255)
			},
			textshadow = {
				width = 1,
				color = cc.c4b(0, 0, 0, 90),
				size = cc.size(0, -2)
			}
		},
		desc = {
			color = cc.c3b(228, 225, 175),
			offset = {
				-30,
				17
			},
			textOutline = {
				size = 1,
				color = cc.c4b(0, 0, 0, 255)
			}
		},
		cellBg = {
			"musicfestival_btn_14qd_ldj.png",
			"musicfestival_btn_14qd_ld_j.png",
			"musicfestival_btn_14qd_ld_wxz.png",
			"musicfestival_btn_14qd_ld_xz.png",
			"musicfestival_btn_14qd_ld_ylq.png"
		}
	}
}
local lightColor = cc.c3b(180, 180, 180)
local darkColor = cc.c3b(50, 41, 41)

function LoginActivityMediator:initialize()
	super.initialize(self)
end

function LoginActivityMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function LoginActivityMediator:onRegister()
	super.onRegister(self)
end

function LoginActivityMediator:enterWithData(data)
	self._actModel = data.activity
	self._parentMediator = data.parentMediator
	self._cloneCell = self:getView():getChildByFullName("cloneCell")
	self._main = self:getView():getChildByName("main")

	self:setupView()
	self:refreshRightView()
end

function LoginActivityMediator:setupView()
	self._title = self._main:getChildByName("Text_12")
	self._desc = self._main:getChildByName("Text_24")
	self._loginDayList = self._actModel._taskList

	table.sort(self._loginDayList, function(a, b)
		local aNum = a._config.OrderNum
		local bNum = b._config.OrderNum

		return aNum < bNum
	end)

	self._activityConfig = self._actModel:getActivityConfig()

	if self._activityConfig.Title then
		local var_5_0 = Strings:get(self._activityConfig.Title)

		if not var_5_0 then
			var_5_0 = Strings:get("Extra_Login_Day")

			local title = var_5_0

			if self._activityConfig.ActivityDesc then
				local var_5_1 = Strings:get(self._activityConfig.ActivityDesc)

				if not var_5_1 then
					var_5_1 = Strings:get("Extra_Login_Description")

					local desc = var_5_1

					self._title:setString(title)
					self._desc:setString(desc)
					self:getLastRewardDay()
					self:createTableView()

					local space = self._cloneCell:getContentSize().width

					if self._selectTag > 3 then
						self._tableView:setContentOffset(cc.p(-space * (self._selectTag - 3), 0))
					elseif self._selectTag == 0 then
						local todayNum = #self._loginDayList

						for i = 1, #self._loginDayList do
							local taskInfo = self._loginDayList[i]
							local status = taskInfo:getStatus()

							if status == ActivityTaskStatus.kUnfinish then
								todayNum = i - 1

								break
							end
						end

						if todayNum > 3 then
							self._tableView:setContentOffset(cc.p(-space * (todayNum - 3), 0))
						end
					end

					local uiConfig = actUIConfig[self._actModel:getUI()]

					if uiConfig then
						if uiConfig.bgPath then
							local bgImg = self._main:getChildByName("Image_18")

							bgImg:loadTexture(uiConfig.bgPath)
						end

						if uiConfig.title then
							local titleImg = self._main:getChildByName("Image_2")

							if uiConfig.title.img then
								titleImg:loadTexture(uiConfig.title.img, ccui.TextureResType.plistType)
							end

							if uiConfig.title.size then
								titleImg:setContentSize(uiConfig.title.size)
							end

							if uiConfig.title.offset then
								titleImg:offset(uiConfig.title.offset[1], uiConfig.title.offset[2])
							end

							if uiConfig.title.textOffset then
								self._title:offset(uiConfig.title.textOffset[1], uiConfig.title.textOffset[2])
							end

							if uiConfig.title.textPattern then
								local lineGradiantVec2 = {
									{
										ratio = 0.3,
										color = uiConfig.title.textPattern[1]
									},
									{
										ratio = 0.7,
										color = uiConfig.title.textPattern[2]
									}
								}

								self._title:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
									x = 0,
									y = -1
								}))
							end

							if uiConfig.title.textOutline then
								self._title:enableOutline(uiConfig.title.textOutline.color, uiConfig.title.textOutline.size)
							end

							if uiConfig.title.textFontSize then
								self._title:setFontSize(uiConfig.title.textFontSize)
							end

							if uiConfig.title.color then
								self._title:setTextColor(uiConfig.title.color)
							end

							if uiConfig.title.textshadow then
								self._title:enableShadow(uiConfig.title.textshadow.color, uiConfig.title.textshadow.size, uiConfig.title.textshadow.width)
							end
						end

						if uiConfig.desc then
							if uiConfig.desc.color then
								self._desc:disableEffect()
								self._desc:setTextColor(uiConfig.desc.color)
							end

							if uiConfig.desc.offset then
								self._desc:offset(uiConfig.desc.offset[1], uiConfig.desc.offset[2])
							end

							if uiConfig.desc.textOutline then
								self._desc:enableOutline(uiConfig.desc.textOutline.color, uiConfig.desc.textOutline.size)
							end
						end
					end
				end
			end
		end
	end
end

function LoginActivityMediator:getLastRewardDay()
	self._selectTag = 0

	for i = 1, #self._loginDayList do
		local taskInfo = self._loginDayList[i]
		local status = taskInfo:getStatus()

		if status == ActivityTaskStatus.kFinishNotGet then
			self._selectTag = i

			break
		end
	end
end

function LoginActivityMediator:createTableView()
	local tableView = cc.TableView:create(cc.size(770, 330))

	local function scrollViewDidScroll(view)
		return
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		local size = self._cloneCell:getContentSize()

		return size.width, size.height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:updateCell(cell, idx + 1)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._loginDayList
	end

	tableView:setAnchorPoint(0, 0)
	tableView:setPosition(cc.p(218, 85))
	tableView:addTo(self._main)
	tableView:setDelegate()
	tableView:setBounceable(false)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()

	self._tableView = tableView
end

function LoginActivityMediator:updateCell(cell, index)
	local taskInfo = self._loginDayList[index]
	local status = taskInfo:getStatus()
	local reward = taskInfo:getReward()
	local cloneCell = cell:getChildByName("main")

	if not cloneCell then
		cloneCell = self._cloneCell:clone()

		cloneCell:addTo(cell):setName("main")
		cloneCell:setPosition(cc.p(0, 8))
		cloneCell:getChildByName("num1"):ignoreContentAdaptWithSize(true)
	end

	local spDay = self._activityConfig.specailDay
	local title = cloneCell:getChildByName("titleBg")

	title:getChildByName("num"):setString(index)

	local num1Image = cloneCell:getChildByName("num1")

	num1Image:loadTexture("hd_14r_d" .. index .. ".png", 1)

	local select = cloneCell:getChildByName("bgSelect")
	local unselect = cloneCell:getChildByName("bgUnselect")
	local finishAndGetView = cloneCell:getChildByName("finishAndGet")

	title:loadTexture("hd_14r_btn_hdi.png", ccui.TextureResType.plistType)

	local text1 = title:getChildByName("text1")
	local text2 = title:getChildByName("text2")
	local num = title:getChildByName("num")

	text1:setTextColor(lightColor)
	text1:setVisible(false)
	text2:setTextColor(lightColor)
	num:setTextColor(cc.c3b(255, 255, 255))

	local uiConfig = actUIConfig[self._actModel:getUI()]

	if status == ActivityTaskStatus.kGet then
		finishAndGetView:setVisible(true)
		unselect:setVisible(false)
		select:setVisible(false)

		if uiConfig and uiConfig.cellBg then
			finishAndGetView:loadTexture(uiConfig.cellBg[5], ccui.TextureResType.plistType)
		end
	else
		finishAndGetView:setVisible(false)

		if table.indexof(spDay, index) then
			local selectPath = "hd_14r_btn_wxz_j.png"
			local unselectPath = "hd_14r_btn_xz_j.png"

			if uiConfig and uiConfig.cellBg then
				selectPath = uiConfig.cellBg[1]
				unselectPath = uiConfig.cellBg[2]
			end

			select:loadTexture(selectPath, ccui.TextureResType.plistType)
			unselect:loadTexture(unselectPath, ccui.TextureResType.plistType)
		else
			local selectPath = "hd_14r_btn_wxz.png"
			local unselectPath = "hd_14r_btn_xz.png"

			if uiConfig and uiConfig.cellBg then
				selectPath = uiConfig.cellBg[3]
				unselectPath = uiConfig.cellBg[4]
			end

			select:loadTexture(selectPath, ccui.TextureResType.plistType)
			unselect:loadTexture(unselectPath, ccui.TextureResType.plistType)
		end

		if index == self._selectTag then
			select:setVisible(false)
			unselect:setVisible(true)
			title:loadTexture((uiConfig and uiConfig.cellTitle or nil) and uiConfig.cellTitle, ccui.TextureResType.plistType)
			title:getChildByName("text1"):setTextColor(darkColor)
			title:getChildByName("text2"):setTextColor(darkColor)
			title:getChildByName("num"):setTextColor(darkColor)
		else
			select:setVisible(true)
			unselect:setVisible(false)
		end
	end

	text2:setPositionX(num:getPositionX() + num:getContentSize().width / 2 + text2:getContentSize().width + 5)

	local iconNode = cloneCell:getChildByName("rewardIcon")

	iconNode:removeAllChildren()

	local rewardData = reward.Content[1]
	local icon = IconFactory:createRewardIcon(rewardData, {
		isWidget = true
	})

	icon:setScaleNotCascade(0.6)
	icon:setSwallowTouches(false)
	icon:addTo(iconNode):center(iconNode:getContentSize())

	cell.icon = icon

	if status == ActivityTaskStatus.kGet then
		icon:setColor(cc.c3b(120, 120, 120))

		local iamge = ccui.ImageView:create("hd_14r_btn_go.png", ccui.TextureResType.plistType)

		iamge:addTo(iconNode):center(iconNode:getContentSize())
	end

	if self._parentMediator then
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self._parentMediator), rewardData, {
			needDelay = true
		})
	else
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
			needDelay = true
		})
	end

	local rewardName = RewardSystem:getName(rewardData)
	local rewardNameStr = cloneCell:getChildByName("name")

	rewardNameStr:setString(rewardName)

	local strlen = utf8.len(rewardName)

	if strlen > 6 then
		rewardNameStr:setFontSize(14)
	else
		rewardNameStr:setFontSize(18)
	end

	if status == ActivityTaskStatus.kGet then
		rewardNameStr:setTextColor(cc.c3b(164, 160, 160))
		rewardNameStr:enableOutline(cc.c3b(0, 0, 0), 2)
	else
		rewardNameStr:setTextColor(cc.c3b(255, 255, 255))
		rewardNameStr:enableOutline(cc.c3b(83, 72, 54), 2)
	end

	local touchPanel = cloneCell:getChildByName("touchPanel")

	touchPanel:setSwallowTouches(false)
	touchPanel:addClickEventListener(function()
		self:touchCell(index)
	end)
end

function LoginActivityMediator:touchCell(index)
	local cell = self._tableView:cellAtIndex(index - 1)

	if cell and cell.icon and cell.icon.isReturn then
		return
	end

	local taskInfo = self._loginDayList[index]
	local status = taskInfo:getStatus()

	if status == ActivityTaskStatus.kUnfinish then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Extra_Login_Lock", {
				num = index
			})
		}))
	elseif status == ActivityTaskStatus.kFinishNotGet then
		if self._selectTag == index then
			self:requsetGetReward(self._actModel:getId(), taskInfo:getId())
		else
			self._selectTag = index

			local offX = self._tableView:getContentOffset().x

			self._tableView:reloadData()
			self._tableView:setContentOffset(cc.p(offX, 0))
		end
	elseif status == ActivityTaskStatus.kGet then
		-- block empty
	end
end

function LoginActivityMediator:requsetGetReward(activityId, taskId)
	local data = {
		doActivityType = 101,
		taskId = taskId
	}

	self._activitySystem:requestDoActivity(activityId, data, function(response)
		if checkDependInstance(self) then
			self:getLastRewardDay()

			local offX = self._tableView:getContentOffset().x

			self._tableView:reloadData()
			self._tableView:setContentOffset(cc.p(offX, 0))

			local rewards = response.data.reward

			if rewards then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = rewards
				}))
			end
		end
	end)
end

function LoginActivityMediator:refreshRightView()
	local activityConfig = self._actModel:getActivityConfig()

	self._main:getChildByFullName("heroPanel.Image_33"):setVisible(not activityConfig.showHero)

	if activityConfig.showHero then
		local heroPanel = self._main:getChildByName("heroPanel")
		local roleModel = IconFactory:getRoleModelByKey("HeroBase", activityConfig.showHero)
		local heroSprite = IconFactory:createRoleIconSpriteNew({
			frameId = "bustframe9",
			id = roleModel
		})

		heroSprite:setScale(0.85)
		heroSprite:addTo(heroPanel)
		heroSprite:setPosition(cc.p(345, 140))
	end

	if self._actModel:getUI() == ActivityType.KLOGINTIME then
		local resFile = "asset/ui/ActivityLoginLover.csb"
		local node = cc.CSLoader:createNode(resFile)

		node:addTo(self._main, 10):setName("loverView")

		if activityConfig and activityConfig.TaskTopUI then
			node:getChildByFullName("main.Image_2"):loadTexture(activityConfig.TaskTopUI .. ".png", ccui.TextureResType.plistType)
		end

		self._main:getChildByName("Text_12"):setString("")
		self._main:getChildByName("Text_24"):setString("")
		self._main:getChildByName("Image_2"):setVisible(false)

		self._refreshPanel = node:getChildByFullName("main.refreshPanel")
		self._refreshTime = self._refreshPanel:getChildByName("times")
		self._descPanel = node:getChildByFullName("main.desc")

		self._descPanel:setString(Strings:get(self._actModel:getDesc()))
		self._descPanel:getVirtualRenderer():setLineSpacing(2)
		self:setTimer()

		return
	end

	if activityConfig and activityConfig.TaskBgUI then
		self._main:getChildByName("Image_18"):loadTexture("asset/scene/" .. activityConfig.TaskBgUI .. ".jpg")
	end
end

function LoginActivityMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._refreshPanel then
		self._refreshPanel:setVisible(false)
	end
end

function LoginActivityMediator:setTimer()
	self:stopTimer()

	if not self._actModel then
		return
	end

	self._refreshPanel:setVisible(true)

	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = self._actModel:getEndTime() / 1000

	if remoteTimestamp < endMills and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()

			local endMills = self._actModel:getEndTime() / 1000
			local remainTime = endMills - remoteTimestamp

			if math.floor(remainTime) <= 0 then
				self:stopTimer()

				return
			end

			local fmtStr = "${d}:${H}:${M}:${S}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])

			self._refreshTime:setString((timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")) .. Strings:get("Activity_Collect_Finish"))
			self._refreshPanel:setVisible(true)
		end

		checkTimeFunc()

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
	end
end
