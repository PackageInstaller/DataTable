-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulategift/view/DreamIslandView.lua

module("logic.extensions.accumulategift.view.DreamIslandView", package.seeall)

local DreamIslandView = class("DreamIslandView", TableViewComponent)

function DreamIslandView:ctor()
	DreamIslandView.super.ctor(self)

	self._weekBtnList = nil
	self._dayBtnList = nil
	self._openDay = nil
	self._choWeekNum = 1
	self._choDayNum = 1
	self._scoreEffList = nil
	self._scoreItemList = nil
	self._showSpriteTime = 0
end

function DreamIslandView:onExitFinished()
	DreamIslandView.super.onExitFinished(self)
end

function DreamIslandView:onEnterFinished()
	DreamIslandView.super.onEnterFinished(self)
end

function DreamIslandView:bindEvents()
	DreamIslandView.super.bindEvents(self)
	self.backClickBtn:AddClickListener(function()
		DreamIslandModel.instance:GetSetChoiseTableNums(true)
		self:close()
	end, self)
	GameUtil.asBtn(self.spriteClickGo):AddClickListener(self._OnClickSpriteRawBtn, self)

	for i = 1, 7 do
		local index = i

		if self._weekBtnList and self._weekBtnList[index] and self._weekBtnList[index].itemGo then
			GameUtil.asBtn(self._weekBtnList[index].itemGo):AddClickListener(function()
				self:_OnClickWeekBtn(index, 1)
			end, self)
		end

		if self._dayBtnList and self._dayBtnList[index] and self._dayBtnList[index].itemGo then
			GameUtil.asBtn(self._dayBtnList[index].itemGo):AddClickListener(function()
				self:_OnClickWeekBtn(self._choWeekNum, index)
			end, self)
		end
	end
end

function DreamIslandView:unbindEvents()
	DreamIslandView.super.unbindEvents(self)
	self.backClickBtn:RemoveClickListener()
	GameUtil.asBtn(self.spriteClickGo):RemoveClickListener()

	for i = 1, 7 do
		if self._weekBtnList and self._weekBtnList[i] and self._weekBtnList[i].itemGo then
			GameUtil.asBtn(self._weekBtnList[i].itemGo):RemoveClickListener()
		end

		if self._dayBtnList and self._dayBtnList[i] and self._dayBtnList[i].itemGo then
			GameUtil.asBtn(self._dayBtnList[i].itemGo):RemoveClickListener()
		end
	end
end

function DreamIslandView:onExit()
	removetimer(self._CalculationSurplusTime, self)
	MaterialMgr.clearIcon(self.nowScoreImaGo)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	for _, eff in pairs(self._scoreEffList or {}) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self._scoreEffList = nil

	GlobalDispatcher:removeListener("UpdataDreamIslandTask", self._UpdataDreamIslandTask, self)

	self._curViewDatas = nil
	self._showSpriteTime = 0
	self._roleObj = RoleObjectPool.instance:removeRole(self._roleObj)
end

function DreamIslandView:destroyUI()
	DreamIslandView.super.destroyUI(self)

	self._weekBtnList = nil
	self._dayBtnList = nil
	self._openDay = nil
end

function DreamIslandView:buildUI()
	DreamIslandView.super.buildUI(self)

	self.backClickBtn = self:getBtn("backClickBtn")
	self.roleCon = self:getGo("roleCon")
	self.spriteClickGo = self:getGo("spriteClickGo")
	self.spriteTimeTxt = goutil.findChildTextComponent(self.mainGO, "spriteTimeTxt")
	self.spriteTimeTxt.text = ""
	self.sloganGo = self:getGo("sloganGo")
	self.sloganTxt = goutil.findChildTextComponent(self.sloganGo, "sloganTxt")
	self.sloganTxt.text = ""

	GameUtil.SetActive(self.sloganGo, false)

	local scoreInfoGo = self:getGo("scoreInfoGo")

	self.scoreBarSli = goutil.findChildComponent(scoreInfoGo, "scoreBarSli", "Slider")
	self.goodsShowTran = goutil.findChild(scoreInfoGo, "goodsShowTran").transform
	self.nowScoreImaGo = goutil.findChild(scoreInfoGo, "nowScoreSpt/nowScoreIma")
	self.nowScoreTxt = goutil.findChildTextComponent(scoreInfoGo, "nowScoreSpt/nowScoreTxt")
	self.goodsItemGo = goutil.findChild(scoreInfoGo, "goodsItemGo")
	self.scoreBarSli.value = 0
	self.nowScoreTxt.text = ""

	GameUtil.SetActive(self.goodsItemGo, false)

	local weekBtnTran = self:getGo("weekBtnTran").transform

	self._weekBtnList = {}

	for i = 1, 7 do
		local btnGo = weekBtnTran:GetChild(i - 1)
		local names = string.split(btnGo.name, "_")

		self._weekBtnList[tonumber(names[2])] = {
			itemGo = btnGo,
			iconIma = goutil.findChildComponent(btnGo, "dayIconIma", "UIImageSpriteChange"),
			nameTxt = goutil.findChildTextComponent(btnGo, "dayNameTxt"),
			lockGo = goutil.findChild(btnGo, "lockGo"),
			redpointGo = goutil.findChild(btnGo, "redpointGo")
		}
	end

	local dayBtnTran = self:getGo("dayBtnTran").transform

	self._dayBtnList = {}

	for i = 1, 7 do
		local btnGo = dayBtnTran:GetChild(i - 1)
		local names = string.split(btnGo.name, "_")

		self._dayBtnList[tonumber(names[2])] = {
			itemGo = btnGo,
			iconIma = goutil.findChildComponent(btnGo, "dayIconIma", "UIImageSpriteChange"),
			nameTxt = goutil.findChildTextComponent(btnGo, "dayNameTxt"),
			lockGo = goutil.findChild(btnGo, "lockGo"),
			redpointGo = goutil.findChild(btnGo, "redpointGo")
		}
	end
end

function DreamIslandView:onEnter()
	DreamIslandView.super.onEnter(self)
	GlobalDispatcher:addListener("UpdataDreamIslandTask", self._UpdataDreamIslandTask, self)

	self._fakeId = DreamIslandConfig.instance:GetDreamIslandParams("fakeId")

	local _choTableNums = DreamIslandModel.instance:GetSetChoiseTableNums()

	self._choWeekNum, self._choDayNum = checknumber(_choTableNums.weekNum), checknumber(_choTableNums.dayNum)

	MaterialMgr.setIcon(self.nowScoreImaGo, MatType.Item_Fake, self._fakeId)

	self._pmEff = UIEffectManager.instance:playEffect(self, "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab", self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)

	if self._weekBtnList and #self._weekBtnList > 0 then
		for i = 1, #self._weekBtnList do
			self._weekBtnList[i].iconIma:SetState(0)

			self._weekBtnList[i].nameTxt.text = string.format("第%s周", ConstString.ChineseNumber[i])

			GameUtil.SetActive(self._weekBtnList[i].lockGo, false)
			GameUtil.SetActive(self._weekBtnList[i].redpointGo, false)
		end
	end

	if self._dayBtnList and #self._dayBtnList > 0 then
		for i = 1, #self._dayBtnList do
			self._dayBtnList[i].iconIma:SetState(0)

			self._dayBtnList[i].nameTxt.text = string.format("第%s天", ConstString.ChineseNumber[i])

			GameUtil.SetActive(self._dayBtnList[i].lockGo, false)
			GameUtil.SetActive(self._dayBtnList[i].redpointGo, false)
		end
	end

	self.spriteTimeTxt.text = ""

	self:_UpdataDreamIslandTask(1)
	DreamIslandController.instance:CSRequestDreamIslandTaskData()
end

function DreamIslandView:_UpdataDreamIslandTask(updataType)
	self._actiId = DreamIslandModel.instance:GetOpenActivityId()

	if checknumber(self._actiId) <= 0 then
		printError("sr--- DreamIslandView:_UpdataDreamIslandTask()    梦之岛活动结束怎么还能打开？ _actiId = " .. self._actiId)

		return
	end

	local day, endTime = DreamIslandModel.instance:GetNowActivityTime()

	self._openDay = 1

	if checknumber(day) > 0 then
		self._openDay = day
	end

	if checknumber(updataType) == 1 then
		removetimer(self._CalculationSurplusTime, self)
		self:_OnClickWeekBtn(self._choWeekNum, self._choDayNum)

		self._supTime = math.floor(endTime - ServerTime.nowServerLook())

		self:_CalculationSurplusTime()
		settimer(1, self._CalculationSurplusTime, self, true)
	elseif checknumber(updataType) == 3 then
		self:_OnClickWeekBtn(self._choWeekNum, self._choDayNum)
	end

	self:_ShowScoreInfo()
end

function DreamIslandView:_OnClickWeekBtn(num1, num2)
	num1 = num1 or self._choWeekNum
	num2 = num2 or self._choDayNum

	local _nowNum = (num1 - 1) * 7 + num2

	if _nowNum > self._openDay then
		FloatWordMgr.instance:show("活动暂未开启！")

		return
	end

	self._weekBtnList[num1].iconIma:SetState(1)

	if self._choWeekNum ~= num1 then
		self._weekBtnList[self._choWeekNum].iconIma:SetState(0)

		self._choWeekNum = num1
	end

	self._dayBtnList[num2].iconIma:SetState(1)

	if self._choDayNum ~= num2 then
		self._dayBtnList[self._choDayNum].iconIma:SetState(0)

		self._choDayNum = num2
	end

	self:_ShowSpriteInfo()
	self:_UpdataWeekAndDayRedPoint()

	self._showSpriteTime = 0
	self.sloganTxt.text = ""

	GameUtil.SetActive(self.sloganGo, false)

	self._curViewDatas = DreamIslandModel.instance:GetDreamIslandTasks(_nowNum) or {}

	self._tableview:ReloadData()
	self._tableview:MoveCellInView(0, false)
end

function DreamIslandView:_ShowSpriteInfo()
	local _nowNum = (self._choWeekNum - 1) * 7 + self._choDayNum
	local cfg = DreamIslandConfig.instance:GetDayPetInfoCfg(self._actiId, _nowNum)

	if cfg == nil or checknumber(cfg.raceId) <= 0 then
		printError("sr--- 重回梦之岛  DreamIslandView:_ShowSpriteInfo()  精灵信息无配置 = " .. _nowNum)

		return
	end

	local posList = cfg.rawPos
	local x, y, scale = 0, 0, 1

	if posList then
		x = posList[1] or 0
		y = posList[2] or 0
		scale = posList[3] or 1
	end

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, checknumber(cfg.raceId), self.roleCon, scale, nil, true, x, y)
end

function DreamIslandView:_CalculationSurplusTime()
	if self._supTime <= 0 then
		self.spriteTimeTxt.text = "活动结束"

		if self._supTime == 0 then
			FloatWordMgr.instance:show("活动结束，界面即将关闭！")
		end

		if self._supTime <= -2 then
			removetimer(self._CalculationSurplusTime, self)
			self:close()

			return
		end
	else
		if self._showSpriteTime <= 0 and self.sloganGo.activeSelf then
			self._showSpriteTime = 0
			self.sloganTxt.text = ""

			GameUtil.SetActive(self.sloganGo, false)
		end

		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._supTime)

		self.spriteTimeTxt.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
	end

	self._supTime = self._supTime - 1
end

function DreamIslandView:_OnClickSpriteRawBtn()
	if self._showSpriteTime <= 0 then
		local _nowNum = (self._choWeekNum - 1) * 7 + self._choDayNum
		local cfg = DreamIslandConfig.instance:GetDayPetInfoCfg(self._actiId, _nowNum)

		if cfg == nil or string.nilorempty(cfg.des) then
			printError("sr--- 重回梦之岛  DreamIslandView:_OnClickSpriteRawBtn()  精灵描述空 = " .. _nowNum)

			return
		end

		GameUtil.SetActive(self.sloganGo, true)

		self.sloganTxt.text = cfg.des
	end

	self._showSpriteTime = 5
end

function DreamIslandView:_UpdataWeekAndDayRedPoint()
	local _startNum = 1 + (self._choWeekNum - 1) * 7

	if self._dayBtnList and #self._dayBtnList > 0 then
		for i = 1, #self._dayBtnList do
			local _nowNum = _startNum + i - 1

			if _nowNum <= self._openDay then
				GameUtil.SetActive(self._dayBtnList[i].lockGo, false)

				local _isRed = DreamIslandModel.instance:GetDayRedPoint(_nowNum)

				GameUtil.SetActive(self._dayBtnList[i].redpointGo, _isRed)
			else
				GameUtil.SetActive(self._dayBtnList[i].lockGo, true)
				GameUtil.SetActive(self._dayBtnList[i].redpointGo, false)
			end
		end
	end

	local _openWeekNum = math.ceil(self._openDay / 7)

	if self._weekBtnList and #self._weekBtnList > 0 then
		for i = 1, #self._weekBtnList do
			if i <= _openWeekNum then
				GameUtil.SetActive(self._weekBtnList[i].lockGo, false)

				local _isRed = DreamIslandModel.instance:GetWeekRedPoint(i)

				GameUtil.SetActive(self._weekBtnList[i].redpointGo, _isRed)
			else
				GameUtil.SetActive(self._weekBtnList[i].lockGo, true)
				GameUtil.SetActive(self._weekBtnList[i].redpointGo, false)
			end
		end
	end
end

function DreamIslandView:_ShowScoreInfo()
	self._scoreEffList = self._scoreEffList or {}

	local _scoreInfo = DreamIslandModel.instance:GetDreamIslandScore()
	local allScore = 0
	local haveScore = 0
	local count = 0

	if _scoreInfo then
		allScore = _scoreInfo.allScore
		haveScore = _scoreInfo.haveScore
		count = #_scoreInfo.scoreList
	end

	self.nowScoreTxt.text = tostring(haveScore)
	self._scoreItemList = self._scoreItemList or {}
	self.scoreBarSli.value = 0

	if count > 0 then
		local allX = 750
		local oneX = allX / count
		local jd = 1
		local scoreList = _scoreInfo.scoreList

		for i = 1, count do
			if self._scoreItemList[i] == nil then
				local go = UnityEngine.GameObject.Instantiate(self.goodsItemGo, self.goodsShowTran)

				go.name = "goodsItem_" .. i
				self._scoreItemList[i] = {
					itemGo = go,
					goodsGo = goutil.findChild(go, "goodsGo"),
					receiveCountTxt = goutil.findChildTextComponent(go, "receiveCountTxt"),
					receiveShowGo = goutil.findChild(go, "receiveShowGo"),
					itemBtnGo = goutil.findChild(go, "itemBtnGo")
				}
			end

			self._scoreItemList[i].itemGo:SetActive(true)
			MaterialMgr.resetAll(self._scoreItemList[i].goodsGo)
			Framework.TransformUtil.SetLocalPos(self._scoreItemList[i].itemGo.transform, i * oneX, 0, 0)

			self._scoreItemList[i].receiveCountTxt.text = tostring(scoreList[i].needScore)

			local marType = checknumber(scoreList[i].goodsList[1])
			local marId = checknumber(scoreList[i].goodsList[2])
			local marNum = checknumber(scoreList[i].goodsList[3])
			local subLua = MaterialMgr.setCell(marType, marId, self._scoreItemList[i].goodsGo)

			subLua.binder:setNum(marNum)

			if scoreList[i].isReceive then
				if self._scoreEffList[i] then
					UIEffectManager.instance:stopEffect(self._scoreEffList[i])

					self._scoreEffList[i] = nil
				end

				self._scoreItemList[i].receiveShowGo:SetActive(true)
				subLua.binder:setAutoTips(false)
				uGuiUtil.setImageAlpha(self._scoreItemList[i].itemBtnGo:GetComponent("Image"), 0.2)

				if jd < i then
					jd = i
				end
			else
				uGuiUtil.setImageAlpha(self._scoreItemList[i].itemBtnGo:GetComponent("Image"), 0)
				self._scoreItemList[i].receiveShowGo:SetActive(false)

				if haveScore >= scoreList[i].needScore then
					subLua.binder:setAutoTips(false)

					if jd < i then
						jd = i
					end

					if self._scoreEffList[i] == nil then
						local effPath = "fx_ui_qirirenwu/fx_qirirenwu_kelingqu.prefab"

						self._scoreEffList[i] = UIEffectManager.instance:playEffect(self, effPath, self._scoreItemList[i].itemBtnGo, 0, 0, true, nil, nil, nil, self)

						self._scoreEffList[i]:setParent(self._scoreItemList[i].itemBtnGo.transform)
						self._scoreEffList[i]:setLocalPos(0, 10.8, 0)
						self._scoreEffList[i]:setScale(1)
					end
				elseif self._scoreEffList[i] then
					UIEffectManager.instance:stopEffect(self._scoreEffList[i])

					self._scoreEffList[i] = nil
				end
			end

			local index = i

			GameUtil.asBtn(self._scoreItemList[i].itemBtnGo):AddClickListener(function()
				if scoreList[i].isReceive then
					FloatWordMgr.instance:show("已领取！")

					return
				end

				if scoreList[i].needScore > haveScore then
					FloatWordMgr.instance:show("未达到领取条件！")

					return
				end

				DreamIslandController.instance:CSRequestReceiveScore(index - 1)
			end, self)
		end

		if jd < count then
			local sy = haveScore - scoreList[jd].needScore
			local yy = scoreList[jd + 1].needScore - scoreList[jd].needScore

			self.scoreBarSli.value = jd / count + sy / (count * yy)
		else
			self.scoreBarSli.value = 1
		end
	end

	if count < #self._scoreItemList then
		for i = count + 1, #self._scoreItemList do
			if self._scoreItemList[i] and self._scoreItemList[i].itemGo.activeSelf then
				self._scoreItemList[i].itemGo:SetActive(false)
			end
		end
	end
end

function DreamIslandView:_getPath()
	return {
		cellPath = "itemInfoGo",
		viewPath = "itemListSR"
	}
end

function DreamIslandView:_cellSize()
	return 790, 118
end

function DreamIslandView:_updateCell(view, cell, data)
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local desTxt = goutil.findChildTextComponent(cell, "desTxt")
	local cellGoList = {
		goutil.findChild(cell, "cellGo_1"),
		goutil.findChild(cell, "cellGo_2"),
		goutil.findChild(cell, "cellGo_3")
	}
	local countTxt = goutil.findChildTextComponent(cell, "countTxt")
	local receiveBtnGo = goutil.findChild(cell, "receiveBtn")
	local receiveSpt = receiveBtnGo:GetComponent("UIImageSpriteChange")
	local receiveTxt = goutil.findChildTextComponent(cell, "receiveBtn/receiveTxt")
	local receiveGo = goutil.findChild(cell, "receiveGo")

	if cellGoList and #cellGoList > 0 then
		for i = 1, #cellGoList do
			MaterialMgr.resetAll(cellGoList[i])
		end
	end

	nameTxt.text = data.title
	desTxt.text = data.desc

	receiveGo:SetActive(data.isReceive)

	if data.isReceive then
		receiveTxt.text = ""
		countTxt.text = ""

		receiveBtnGo:SetActive(false)
	else
		countTxt.text = data.haveCount .. "/" .. data.needCount

		if data.isReach then
			receiveBtnGo:SetActive(true)
			receiveSpt:SetState(1)

			receiveTxt.text = "领取"

			Framework.TransformUtil.SetLocalPos(countTxt.gameObject.transform, 272, 22, 0)
		elseif string.nilorempty(data.jumpTo) then
			receiveBtnGo:SetActive(false)

			receiveTxt.text = ""

			Framework.TransformUtil.SetLocalPos(countTxt.gameObject.transform, 272, 0, 0)
		else
			receiveBtnGo:SetActive(true)
			receiveSpt:SetState(0)

			receiveTxt.text = "前往"

			Framework.TransformUtil.SetLocalPos(countTxt.gameObject.transform, 272, 22, 0)
		end
	end

	for i = 1, (data.prizeList and #data.prizeList > 0 or nil) and #data.prizeList + 1 do
		if i > 1 then
			if not data.prizeList[i - 1] then
				local str = string.format("1004:%s:%s", self._fakeId, data.score)
				local goodsInfo = string.split(str, ":")

				if goodsInfo and #goodsInfo > 2 and cellGoList and cellGoList[i] then
					local subLua = MaterialMgr.setCell(tonumber(goodsInfo[1]), tonumber(goodsInfo[2]), cellGoList[i])

					subLua.binder:setNum(tonumber(goodsInfo[3]))
				end
			end
		end
	end

	if data.isReceive then
		return
	end

	GameUtil.asBtn(receiveBtnGo):AddClickListener(function()
		if data.isReach then
			DreamIslandController.instance:CSRequestReceiveTask(data.id)

			return
		end

		if string.nilorempty(data.jumpTo) then
			FloatWordMgr.instance:show("未满足领取条件！")
		else
			DreamIslandModel.instance:GetSetChoiseTableNums(false, self._choWeekNum, self._choDayNum)
			GotoMgr.gotoByString(data.jumpTo)
		end
	end, self)
end

return DreamIslandView
