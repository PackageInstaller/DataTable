-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/component/PetRaceRegistLayer.lua

PetRaceRegistLayer = class("PetRaceRegistLayer", DmBaseUI)

PetRaceRegistLayer:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

local kBtnHandlers = {
	["Panel_base.bg"] = "onClickBg",
	["Panel_base.Node_regist.Node_autoBtn.Button_autoRegist"] = "onClickAutoRegist",
	["Panel_base.Node_regist.Node_select.Image_select_bg"] = "onClickSelectBox"
}
local kSelectBg = {
	"smzb_btn_xl_1.png",
	"smzb_btn_xl_2.png"
}
local kStatus = {
	open = 1,
	registed = 5,
	ended = 4,
	notOpen = 2,
	full = 3,
	none = 6
}
local kStatusImg = {
	[kStatus.open] = "smzb_icon_kebao.png",
	[kStatus.notOpen] = "smzb_icon_weikai.png",
	[kStatus.full] = "smzb_icon_baoman.png",
	[kStatus.ended] = "smzb_icon_jieshu.png",
	[kStatus.registed] = "smzb_icon_yibao.png"
}

function PetRaceRegistLayer:initialize(data)
	super.initialize(self)
	self:setView(data.view)
	self:mapButtonHandlersClick(kBtnHandlers)
	AdjustUtils.adjustLayoutUIByRootNode(self:getView())
end

function PetRaceRegistLayer:userInject()
	self._button_regist = bindWidget(self, "Panel_base.Node_regist.Node_button.Button_regist", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClickRegist, self)
		}
	})
	self._button_embattle = bindWidget(self, "Panel_base.Node_regist.Node_button.Button_embattle", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Open_2",
			func = bind1(self.onClickEmbattle, self)
		}
	})

	self:intiView()
end

function PetRaceRegistLayer:intiView()
	local node_regist = self:getView():getChildByFullName("Panel_base.Node_regist")

	self._image_autoRegist = node_regist:getChildByFullName("Node_autoBtn.Image_autoRegist")
	self._node_anim = self:getView():getChildByFullName("Panel_base.Node_anim")
	self._node_select = node_regist:getChildByFullName("Node_select")
	self._select_item = node_regist:getChildByName("Image_select_item")
	self._select_bg = self._node_select:getChildByName("Image_select_bg")
	self._select_start_time = self._node_select:getChildByName("Text_select_time")
	self._register_num = node_regist:getChildByName("Text_register_num")

	local autobtn = node_regist:getChildByName("Node_autoBtn")
	local text_autoRegist = node_regist:getChildByName("Text_autoRegist")

	if not self._petRaceSystem:isAutoEnable() then
		autobtn:setVisible(false)
		text_autoRegist:setVisible(false)
	else
		autobtn:setVisible(true)
		text_autoRegist:setVisible(true)
	end

	self:initSelectIndex()
end

function PetRaceRegistLayer:refreshView()
	local node_regist = self:getView():getChildByFullName("Panel_base.Node_regist")
	local node_des_regist = node_regist:getChildByName("Node_des_regist")

	node_des_regist:setVisible(false)
	self:updateButtonState()

	local autoRegist = self._petRaceSystem:isAutoRegist()

	if autoRegist then
		self._image_autoRegist:setVisible(true)
	else
		self._image_autoRegist:setVisible(false)
	end
end

function PetRaceRegistLayer:showTip(str)
	self:dispatch(ShowTipEvent({
		duration = 0.5,
		tip = str
	}))
end

function PetRaceRegistLayer:onClickRegist(sender, eventType)
	if self._petRaceSystem:isMaxRegist() then
		self:showTip(Strings:get("Petrace_Text_4"))

		return
	end

	local selectIndex = self._petRaceSystem:getSelectIndex()
	local matchStatus = self:getMatchStatus()

	if matchStatus[selectIndex].status == kStatus.ended then
		self:showTip(Strings:get("Petrace_Text_117"))

		return
	end

	local function regist_cb(response)
		self:showTip(Strings:get("Petrace_Text_118", {
			time = matchStatus[selectIndex].time
		}))
		self:refreshView()
		self._petRaceSystem:forceResetEmbattle()
	end

	self._petRaceSystem:regist({
		gameIndex = selectIndex - 1
	}, regist_cb, true)
end

function PetRaceRegistLayer:onClickEmbattle(sender, eventType)
	local view = self:getInjector():getInstance("PetRaceEmbattleForRegistView")
	local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, "PetRaceEmbattleForRegistView")

	self:dispatch(event)
end

function PetRaceRegistLayer:onClickAutoRegist(sender, eventType)
	local autoRegist = self._petRaceSystem:isAutoRegist()

	if autoRegist then
		self._petRaceSystem:requestAutoRegist(0)
	else
		self._petRaceSystem:requestAutoRegist(1)
	end
end

function PetRaceRegistLayer:onClickSelectBox(sender, eventType)
	self:initSelectBox()
end

function PetRaceRegistLayer:onClickBg(sender, eventType)
	if self._selectBox then
		self._selectBox:removeFromParent(true)

		self._selectBox = nil
	end
end

function PetRaceRegistLayer:createAnim()
	local anim = cc.MovieClip:create("all_shengshizhengba")

	anim:setPlaySpeed(1.5)

	local timeNode = anim:getChildByName("timeNode")
	local desNode = anim:getChildByName("desNode")
	local desIconNode = anim:getChildByName("desIconNode")
	local lineIconNode = anim:getChildByName("lineIconNode")
	local centerbgNode = anim:getChildByName("centerbgNode")
	local maxBgNode = anim:getChildByName("maxBgNode")
	local buttonNode = anim:getChildByName("buttonNode")
	local node_des_regist = self:getView():getChildByFullName("Panel_base.Node_regist.Node_des_regist")
	local button_embattle = self:getView():getChildByFullName("Panel_base.Node_regist.Node_button")
	local text_autoRegist = self:getView():getChildByFullName("Panel_base.Node_regist.Text_autoRegist")
	local Button_autoRegist = self:getView():getChildByFullName("Panel_base.Node_regist.Node_autoBtn")
	local text_register_num = self:getView():getChildByFullName("Panel_base.Node_regist.Text_register_num")
	local node_select = self:getView():getChildByFullName("Panel_base.Node_regist.Node_select")
	local bg = self:getView():getChildByFullName("Panel_base.bg")
	local image_center = self:getView():getChildByFullName("Panel_base.Image_1")
	local image_line = self:getView():getChildByFullName("Panel_base.Image_2")
	local image_textDes = self:getView():getChildByFullName("Panel_base.Image_3")
	local text_title1 = self:getView():getChildByFullName("Panel_base.Text_title1")
	local text_title2 = self:getView():getChildByFullName("Panel_base.Text_title2")
	local text_title3 = self:getView():getChildByFullName("Panel_base.Text_title3")
	local nodeToActionMap = {}

	nodeToActionMap[button_embattle] = buttonNode
	nodeToActionMap[text_autoRegist] = buttonNode
	nodeToActionMap[Button_autoRegist] = buttonNode
	nodeToActionMap[text_register_num] = buttonNode
	nodeToActionMap[node_select] = buttonNode
	nodeToActionMap[bg] = maxBgNode
	nodeToActionMap[image_center] = centerbgNode
	nodeToActionMap[image_line] = maxBgNode
	nodeToActionMap[image_textDes] = desIconNode
	nodeToActionMap[text_title1] = desNode
	nodeToActionMap[text_title2] = desNode
	nodeToActionMap[text_title3] = desNode

	local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, self._node_anim)

	startFunc()
	anim:addTo(self._node_anim)
	anim:gotoAndPlay(0)
	anim:setVisible(false)
	anim:addCallbackAtFrame(60, function(cid, mc)
		stopFunc()
		mc:stop()
		mc:removeFromParent(true)
	end)

	local jjAnim = cc.MovieClip:create("jingjirukou_jingjirukou")

	jjAnim:setPosition(cc.p(0, 0))
	self._node_anim:addChild(jjAnim)
	jjAnim:addCallbackAtFrame(12, function()
		jjAnim:stop()
	end)
end

function PetRaceRegistLayer:initSelectIndex()
	local enterIndex = self._petRaceSystem:getPetRace():getEnterIndex()
	local matchStatus = self:getMatchStatus()

	if enterIndex ~= -1 then
		if not (enterIndex + 1) then
			local selectIndex = self._petRaceSystem:getPetRace():getCurIndex() + 1
			local enableMatch = {}

			for k, v in pairs(matchStatus) do
				if v.status == kStatus.open then
					enableMatch[#enableMatch + 1] = v
				end
			end

			if #enableMatch > 0 then
				local randomIndex = math.random(1, #enableMatch)

				selectIndex = enableMatch[randomIndex].index
			end

			self._petRaceSystem:setSelectIndex(selectIndex)
			self:updateStatus(matchStatus[selectIndex])
		end
	end
end

function PetRaceRegistLayer:updateStatus(roundStatus)
	if not roundStatus then
		return
	end

	self._select_start_time:setString(Strings:get("Petrace_Text_116", {
		num = roundStatus.index,
		time = roundStatus.time
	}))
	self._register_num:setString(roundStatus.curNum .. "/" .. roundStatus.limit)

	if roundStatus.status == kStatus.full then
		self._button_regist:setButtonName(Strings:get("Petrace_Text_115"), Strings:get("UIPVP_EN_Baomingyiman"))
	elseif roundStatus.status == kStatus.ended then
		self._button_regist:setButtonName(Strings:get("Petrace_Text_119"), Strings:get("UIPVP_EN_Yikaisai"))
	else
		self._button_regist:setButtonName(Strings:get("Petrace_Text_56"), Strings:get("UIPVP_EN_Baoming"))
	end
end

function PetRaceRegistLayer:updateButtonState()
	local matchStatus = self:getMatchStatus()
	local selectIndex = self._petRaceSystem:getSelectIndex()
	local status = matchStatus[selectIndex].status
	local enterIndex = self._petRaceSystem:getPetRace():getEnterIndex()

	if enterIndex + 1 == selectIndex and status == kStatus.registed then
		self._button_regist:setVisible(false)
		self._button_embattle:setVisible(true)
		self._button_regist:getView():setGray(false)
		self._button_regist:getButton():setTouchEnabled(true)
	else
		self._button_regist:setVisible(true)
		self._button_embattle:setVisible(false)

		if enterIndex == -1 then
			self._button_regist:getView():setGray(false)
			self._button_regist:getButton():setTouchEnabled(true)
		else
			self._button_regist:getView():setGray(true)
			self._button_regist:getButton():setTouchEnabled(false)
		end
	end
end

function PetRaceRegistLayer:initSelectBox()
	function onClickItem(itemData)
		self._petRaceSystem:setSelectIndex(itemData.index)
		self:updateStatus(itemData)
		self:updateButtonState()
		self._select_bg:loadTexture(kSelectBg[2], ccui.TextureResType.plistType)
		self._selectBox:removeFromParent(true)

		self._selectBox = nil
	end

	function createSelectItem(itemData)
		local itemNode = self._select_item:clone()

		itemNode:setVisible(true)
		itemNode:setTouchEnabled(true)
		itemNode:addTouchEventListener(function(sender, event)
			if event == ccui.TouchEventType.ended then
				onClickItem(itemData)
			end
		end)

		local statusImg = itemNode:getChildByName("Image_status")

		if itemData.status == kStatus.none then
			statusImg:setVisible(false)
		else
			statusImg:setVisible(true)
		end

		statusImg:loadTexture(kStatusImg[itemData.status], ccui.TextureResType.plistType)

		local startTimeText = itemNode:getChildByName("Text_start_time")

		startTimeText:setString(Strings:get("Petrace_Text_116", {
			num = itemData.index,
			time = itemData.time
		}))

		return itemNode
	end

	local dataSource = {
		itemSize = cc.size(245, 43),
		items = self:getMatchStatus(),
		createItemFunc = createSelectItem
	}

	if not self._selectBox then
		self._selectBox = self:createSelectBox(dataSource)

		self._node_select:addChild(self._selectBox)
		self._select_bg:loadTexture(kSelectBg[1], ccui.TextureResType.plistType)
	else
		self._select_bg:loadTexture(kSelectBg[2], ccui.TextureResType.plistType)
		self._selectBox:removeFromParent(true)

		self._selectBox = nil
	end
end

function PetRaceRegistLayer:createSelectBox(dataSource)
	local function calculateContentSize(itemSize, itemNum)
		return {
			width = itemSize.width,
			height = itemSize.height * itemNum
		}
	end

	local size = calculateContentSize(dataSource.itemSize, #dataSource.items)
	local basePanel = ccui.Widget:create()

	basePanel:setAnchorPoint(0.5, 1)
	basePanel:setContentSize(size.width, size.height)

	local idx = 1

	for k, v in pairs(dataSource.items) do
		local itemNode = dataSource.createItemFunc(v)

		itemNode:setPosition(size.width / 2, size.height - idx * dataSource.itemSize.height)
		basePanel:addChild(itemNode)

		idx = idx + 1
	end

	return basePanel
end

function PetRaceRegistLayer:getMatchStatus()
	local ret = {}
	local limitNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "KOF_AutoMaxNum", "content")
	local matchNumbers = ConfigReader:getDataByNameIdAndKey("ConfigValue", "KOF_MatchNumber", "content")
	local enterIndex = self._petRaceSystem:getPetRace():getEnterIndex()
	local curIndex = self._petRaceSystem:getPetRace():getCurIndex()
	local enterList = self._petRaceSystem:getPetRace():getEnterList()
	local state = self._petRaceSystem:getPetRace():getState()

	for idx, num in pairs(enterList) do
		local localDate = TimeUtil:localDate("%H:%M:%S", TimeUtil:getTimeByDateForTargetTimeInToday({
			hour = string.split(matchNumbers[idx], ":")[1],
			min = string.split(matchNumbers[idx], ":")[2],
			sec = string.split(matchNumbers[idx], ":")[3]
		}))

		ret[idx] = {
			index = idx,
			time = localDate,
			limit = limitNum,
			curNum = num
		}

		if state == PetRaceEnum.state.matchOver then
			ret[idx].status = kStatus.ended
		elseif enterIndex ~= -1 then
			if idx < curIndex + 1 then
				ret[idx].status = kStatus.ended
			elseif idx == curIndex + 1 then
				if enterIndex + 1 == idx then
					ret[idx].status = kStatus.registed
				elseif state == PetRaceEnum.state.regist then
					if limitNum <= num then
						ret[idx].status = kStatus.full or kStatus.none
					end
				else
					ret[idx].status = kStatus.ended
				end
			elseif enterIndex + 1 == idx then
				ret[idx].status = kStatus.registed
			elseif limitNum <= num then
				ret[idx].status = kStatus.full or kStatus.none
			end
		elseif idx < curIndex + 1 then
			ret[idx].status = kStatus.ended
		elseif idx == curIndex + 1 then
			if state == PetRaceEnum.state.regist then
				if limitNum <= num then
					ret[idx].status = kStatus.full or kStatus.open
				end
			else
				ret[idx].status = kStatus.ended
			end
		elseif limitNum <= num then
			ret[idx].status = kStatus.full or kStatus.open
		end
	end

	return ret
end
