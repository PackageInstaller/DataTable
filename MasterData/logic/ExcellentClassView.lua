-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/ExcellentClassView.lua

module("logic.extensions.sevendays.view.ExcellentClassView", package.seeall)

local ExcellentClassView = class("ExcellentClassView", ViewComponent)

function ExcellentClassView:ctor()
	ExcellentClassView.super.ctor(self)

	self.choTitleNum = 1
	self.scoreItemList = nil
	self.titleBtnList = nil
	self.itemGoList = nil
	self.classScoreInfo = nil
	self.scoreEffList = nil
end

function ExcellentClassView:onExitFinished()
	return
end

function ExcellentClassView:onEnterFinished()
	return
end

function ExcellentClassView:buildUI()
	ExcellentClassView.super.buildUI(self)

	self.goodsBarSli = self:getGo("goodsBarSli"):GetComponent("Slider")
	self.goodsShowTran = self:getGo("goodsShowTran").transform
	self.goodsItemGo = self:getGo("goodsItemGo")
	self.nowScoreTxt = self:getGo("nowScoreTxt"):GetComponent("Text")
	self.goodsBarSli.value = 0
	self.nowScoreTxt.text = "0"

	self.goodsItemGo:SetActive(false)

	self.titleBtnTran = self:getGo("titleBtnTran").transform
	self.titleGo = self:getGo("titleGo")
	self.titleGo.transform.parent = self.titleBtnTran
	self.InfoGoTran = self:getGo("InfoGoTran").transform
	self.infoItemGo = self:getGo("infoItemGo")
	self.infoItemGo.transform.parent = self.InfoGoTran

	local spriteIconGo = self:getGo("spriteIconGo")

	self.spriteSkillBtn = Framework.ButtonAdapter.GetFrom(spriteIconGo, "spriteSkillBtn")
	self.spriteExplainBtn = Framework.ButtonAdapter.GetFrom(spriteIconGo, "spriteExplainBtn")
	self.spriteNameTxt = goutil.findChildTextComponent(spriteIconGo, "spriteNameTxt")
	self.stageGo = goutil.findChild(spriteIconGo, "stageGo")
	self.spriteNameTxt.text = ""
	self.tipsBtn = self:getBtn("tipsBtn")
	self.viewEffPos = self:getGo("viewEffPos")
	self.supTimeTxt = self:getGo("supTimeTxt"):GetComponent("Text")
	self.supTimeTxt.text = ""

	if self.titleBtnList == nil or #self.titleBtnList == 0 then
		self.titleBtnList = {}
		self.titleGo.name = "titleGo_1"

		self:GetChildGameObjectCom(2, self.titleGo)
	end

	if self.itemGoList == nil or #self.itemGoList == 0 then
		self.itemGoList = {}
		self.infoItemGo.name = "infoItemGo_1"

		self:GetChildGameObjectCom(3, self.infoItemGo)
	end

	self._rulesName = "excellentclass"
end

function ExcellentClassView:bindEvents()
	ExcellentClassView.super.bindEvents(self)
	self.tipsBtn:AddClickListener(function()
		ViewMgr.instance:open(ViewName.RulesView, self._rulesName)
	end, self)
end

function ExcellentClassView:unbindEvents()
	ExcellentClassView.super.unbindEvents(self)
	self.tipsBtn:RemoveClickListener()
	self.spriteSkillBtn:RemoveClickListener()
	self.spriteExplainBtn:RemoveClickListener()
end

function ExcellentClassView:onExit()
	MaterialMgr.resetAll(self.stageGo)

	for _, eff in pairs(self.scoreEffList or {}) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)
		end
	end

	self.scoreEffList = nil

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil

	GlobalDispatcher:removeListener("UpdataExcellentClassTask", self.UpdataExcellentClassTask, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTiliCount, self.SetPower2Update, self)

	self._curViewDatas = nil
	self.classScoreInfo = nil
end

function ExcellentClassView:destroyUI()
	ExcellentClassView.super.destroyUI(self)

	self.choTitleNum = 1

	for _, item in pairs(self.scoreItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.scoreItemList = nil

	for _, item in pairs(self.titleBtnList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.titleBtnList = nil

	for _, item in pairs(self.itemGoList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.itemGoList = nil
end

function ExcellentClassView:onEnter()
	if self.curActId == nil then
		self.curActId = 0
	end

	if self.petId == nil then
		self.petId = 10027
	end

	self.choTitleNum = 1

	if checknumber(SevenDaysModel.instance.classTabIndex) > 0 then
		self.choTitleNum = checknumber(SevenDaysModel.instance.classTabIndex)
	end

	self:StartCreatItems()
	self:UpdataExcellentClassTask()

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.viewEffPos, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.viewEffPos.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
	GlobalDispatcher:addListener("UpdataExcellentClassTask", self.UpdataExcellentClassTask, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataTiliCount, self.SetPower2Update, self)
	SevenDaysController.instance:CSRequestClassInfo(self.curActId)
end

function ExcellentClassView:GetChildGameObjectCom(index, go)
	if go == nil then
		return
	end

	local names = string.split(go.name, "_")
	local num = tonumber(names[2])

	if index == 1 then
		local var_11_0 = {
			itemGo = go,
			needCountTxt = goutil.findChildTextComponent(go, "needCountTxt")
		}

		var_11_0.satisfyIma = goutil.findChild(go, "satisfyIma"):GetComponent("UIImageSpriteChange")
		var_11_0.receiveShowGo = goutil.findChild(go, "receiveShowGo")
		var_11_0.itemBtnGo = goutil.findChild(go, "itemBtnGo")
		self.scoreItemList[num] = var_11_0
	elseif index == 2 then
		self.titleBtnList[num] = {
			itemGo = go,
			itemIconSpt = go:GetComponent("UIChangeGroup"),
			titleNameTxt = goutil.findChildTextComponent(go, "titleNameTxt"),
			titleRedPointGo = goutil.findChild(go, "titleRedPointGo")
		}
	elseif index == 3 then
		local var_11_1 = {
			itemGo = go
		}

		var_11_1.itemScoreTxt = goutil.findChild(go, "itemScoreTxt"):GetComponent("UIImgNumeralText")
		var_11_1.taskDesTxt = goutil.findChildTextComponent(go, "taskDesTxt")
		var_11_1.countBarSli = goutil.findChild(go, "countBarSli"):GetComponent("Slider")
		var_11_1.countShowTxt = goutil.findChildTextComponent(go, "countShowTxt")
		var_11_1.receiveBtnGo = goutil.findChild(go, "receiveBtnGo")
		var_11_1.redPointGo = goutil.findChild(go, "receiveBtnGo/redPointGo")
		var_11_1.receiveSpt = goutil.findChild(go, "receiveBtnGo"):GetComponent("UIImageSpriteChange")
		var_11_1.receiveTxt = goutil.findChildTextComponent(go, "receiveBtnGo/receiveTxt")
		var_11_1.finishGo = goutil.findChild(go, "finishGo")
		var_11_1.goodsItems = {
			goutil.findChild(go, "goodsTran/goodsGo_1"),
			goutil.findChild(go, "goodsTran/goodsGo_2"),
			goutil.findChild(go, "goodsTran/goodsGo_3")
		}
		self.itemGoList[num] = var_11_1
	end
end

function ExcellentClassView:StartCreatItems()
	local goodsId = self.petId
	local cfg = MaterialMgr.getMatCfg(MatType.Pet, goodsId)

	self.spriteNameTxt.text = cfg.name

	local proxy = MaterialMgr.setCell(MatType.Rare, goodsId, self.stageGo)

	proxy.binder:setRare(CharacterConfig.instance:getInitRare(goodsId))
	self.spriteSkillBtn:AddClickListener(function()
		SevenDaysModel.instance.openBonusName = ViewName.ExcellentClass

		BattleFacade.instance:sendPreviewPetBattle(goodsId)
	end, self)
	self.spriteExplainBtn:AddClickListener(function()
		SevenDaysModel.instance.openBonusName = ViewName.ExcellentClass

		PetbookController.instance:openPetinfoView(goodsId)
	end, self)

	local btnTitles = ExcellentClassConfig.instance:GetViewTableNames(self.curActId)

	if btnTitles == nil or #btnTitles == 0 then
		error("sr_精品课程    ExcellentClassView:StartCreatItems()    获取标题名称空！")
	else
		self.titleBtnList = self.titleBtnList or {}

		for i = 1, #btnTitles do
			local index = i

			if self.titleBtnList[index] == nil then
				local go = UnityEngine.GameObject.Instantiate(self.titleGo, self.titleBtnTran)

				go.name = "titleGo_" .. index

				self:GetChildGameObjectCom(2, go)
			end

			self.titleBtnList[index].itemName = btnTitles[index]

			self.titleBtnList[index].itemGo:SetActive(true)

			if index == self.choTitleNum then
				self.titleBtnList[index].itemIconSpt:SetState(0)
			else
				self.titleBtnList[index].itemIconSpt:SetState(1)
			end

			self.titleBtnList[index].titleNameTxt.text = btnTitles[index]

			self.titleBtnList[index].titleRedPointGo:SetActive(false)
			GameUtil.asBtn(self.titleBtnList[index].itemGo):AddClickListener(function()
				self:ClickViewTitleBtn(index)
			end, self)
		end
	end

	self.classScoreInfo = SevenDaysModel.instance:GetClassScoreList(self.curActId)

	local scoreList = {}

	scoreList = self.classScoreInfo and self.classScoreInfo.scoreList or ExcellentClassConfig.instance:GetClsaaScoreCfgs(self.curActId)

	if scoreList == nil or #scoreList == 0 then
		error("sr_精品课程  ExcellentClassView:StartCreatItems()    请检查积分奖励配置")
	else
		self.scoreItemList = self.scoreItemList or {}
		self.nowScoreTxt.text = ""
		self.goodsBarSli.value = 0

		local pos = 576 / #scoreList

		for i = 1, #scoreList do
			local index = i

			if self.scoreItemList[index] == nil then
				local go = UnityEngine.GameObject.Instantiate(self.goodsItemGo, self.goodsShowTran)

				go.name = "goodsItem_" .. index

				self:GetChildGameObjectCom(1, go)
			end

			self.scoreItemList[index].itemGo:SetActive(true)
			Framework.TransformUtil.SetLocalPos(self.scoreItemList[index].itemGo.transform, index * pos, 0, 0)
			self.scoreItemList[index].receiveShowGo:SetActive(false)

			self.scoreItemList[index].needCountTxt.text = tostring(scoreList[index].score)

			local goodsInfo = string.split(scoreList[index].goods, ":")
			local goodsType = tonumber(goodsInfo[1])
			local goodsId = tonumber(goodsInfo[2])
			local subLua = MaterialMgr.setCell(goodsType, goodsId, self.scoreItemList[index].itemGo)

			subLua.binder:setNum(tonumber(goodsInfo[3]))
			subLua.binder:setLvl(tonumber(goodsInfo[4]))
			GameUtil.setLocalScale(subLua.view, 0.6, 0.6, 0.6)
			Framework.TransformUtil.SetLocalPos(subLua.view.transform, 0, 22, 0)
			self.scoreItemList[index].receiveShowGo.transform:SetAsLastSibling()
			self.scoreItemList[index].itemBtnGo.transform:SetAsLastSibling()
			GameUtil.asBtn(self.scoreItemList[index].itemBtnGo):AddClickListener(function()
				self:ClickScoreItemBtn(index)
			end, self)
		end
	end

	self.itemGoList = self.itemGoList or {}

	for i = 1, 3 do
		if self.itemGoList[i] == nil then
			local go = UnityEngine.GameObject.Instantiate(self.infoItemGo, self.InfoGoTran)

			go.name = "infoItemGo_" .. i

			self:GetChildGameObjectCom(3, go)
		end
	end
end

function ExcellentClassView:ClickViewTitleBtn(index, isForce)
	if self.choTitleNum == index and not isForce then
		return
	end

	if self.choTitleNum ~= index and self.titleBtnList and self.titleBtnList[self.choTitleNum] then
		self.titleBtnList[self.choTitleNum].itemIconSpt:SetState(1)

		self.titleBtnList[self.choTitleNum].titleNameTxt.text = self.titleBtnList[self.choTitleNum].itemName
	end

	if self.titleBtnList and self.titleBtnList[index] then
		self.titleBtnList[index].itemIconSpt:SetState(0)

		self.titleBtnList[index].titleNameTxt.text = self.titleBtnList[index].itemName
	end

	self.choTitleNum = index
	SevenDaysModel.instance.classTabIndex = self.choTitleNum
	self._curViewDatas = SevenDaysModel.instance:GetClassTaskList(self.curActId, self.choTitleNum)

	for i = 1, #self.itemGoList do
		local num = i
		local cell = self.itemGoList[num]

		if self._curViewDatas then
			if not self._curViewDatas[num] then
				local info = {}

				if cell and cell.itemGo and info and info.taskId then
					if not cell.itemGo.activeSelf then
						cell.itemGo:SetActive(true)
					end

					local cfg = ExcellentClassConfig.instance:GetClassTaskCfgById(self.curActId, info.taskId)

					if cfg then
						if not cell.itemGo.activeSelf then
							cell.itemGo:SetActive(true)
						end

						cell.itemScoreTxt:SetText(cfg.score)

						cell.taskDesTxt.text = cfg.desc
						cell.countBarSli.value = info.havePro / info.needPro
						cell.countShowTxt.text = string.format("%s/%s", info.havePro, info.needPro)

						cell.redPointGo:SetActive(false)

						local count = 0

						if not string.nilorempty(cfg.prize) then
							local strs = string.split(cfg.prize, "#")

							if strs and #strs > 0 then
								for s = 1, #strs do
									if strs[s] and not string.nilorempty(strs[s]) and cell.goodsItems[s] then
										count = count + 1

										local goodsInfo = string.split(strs[s], ":")
										local goodsType = tonumber(goodsInfo[1])
										local goodsId = tonumber(goodsInfo[2])

										if not cell.goodsItems[s].activeSelf then
											cell.goodsItems[s]:SetActive(true)
										end

										local subLua = MaterialMgr.setCell(goodsType, goodsId, cell.goodsItems[s])

										subLua.binder:setNum(tonumber(goodsInfo[3]))
										GameUtil.setLocalScale(subLua.view, 0.6, 0.6, 0.6)
										Framework.TransformUtil.SetLocalPos(subLua.view.transform, 0, 0, 0)
									end
								end
							end
						end

						if count < #cell.goodsItems then
							for j = count + 1, #cell.goodsItems do
								if cell.goodsItems[j] and cell.goodsItems[j].activeSelf then
									cell.goodsItems[j]:SetActive(false)
								end
							end
						end

						if info.isReceive then
							GameUtil.asBtn(cell.receiveBtnGo):RemoveClickListener()
							cell.finishGo:SetActive(true)
							cell.receiveBtnGo:SetActive(false)
							cell.receiveSpt:SetState(1)

							cell.receiveTxt.text = "已达成"
						else
							if info.havePro >= info.needPro then
								cell.finishGo:SetActive(false)
								cell.receiveBtnGo:SetActive(true)
								cell.receiveSpt:SetState(1)

								cell.receiveTxt.text = "领取"

								cell.redPointGo:SetActive(true)
							else
								cell.finishGo:SetActive(false)
								cell.receiveBtnGo:SetActive(true)
								cell.receiveSpt:SetState(0)

								cell.receiveTxt.text = "前往"
							end

							GameUtil.asBtn(cell.receiveBtnGo):AddClickListener(function()
								if info.needPro <= info.havePro then
									SevenDaysController.instance:CSRequestClassReceive(self.curActId, info.taskId)

									return
								end

								if string.nilorempty(cfg.source) then
									FloatWordMgr.instance:show("未满足领取条件！")
								else
									UIStateManager.instance:push(ViewName.ItemSource, cfg.source, true)
								end
							end, self)
						end
					elseif cell and cell.itemGo and cell.itemGo.activeSelf then
						cell.itemGo:SetActive(false)
					end
				elseif cell and cell.itemGo and cell.itemGo.activeSelf then
					cell.itemGo:SetActive(false)
				end
			end
		end
	end
end

function ExcellentClassView:ClickScoreItemBtn(index)
	if self.classScoreInfo == nil or self.classScoreInfo.scoreList == nil then
		error("sr_精品课程 ExcellentClassView:ClickScoreItemBtn()    积分奖励领取失败 = ", index)

		return
	end

	local info = self.classScoreInfo.scoreList[index]

	if info and info.isReceive then
		FloatWordMgr.instance:show("已领取！")

		return
	end

	if not self.classScoreInfo.haveScore then
		local haveScore = 0

		if info and haveScore >= info.score then
			SevenDaysController.instance:CSRequestClassScore(self.curActId, index - 1)

			return
		end

		FloatWordMgr.instance:show("未达到领取条件！")
	end
end

function ExcellentClassView:UpdataExcellentClassTask()
	self.scoreEffList = self.scoreEffList or {}

	if self.scoreItemList and #self.scoreItemList > 0 then
		self.classScoreInfo = SevenDaysModel.instance:GetClassScoreList(self.curActId)

		local allScore = 0
		local haveScore = 0
		local scoreList = {}

		if self.classScoreInfo then
			allScore = self.classScoreInfo.allScore
			haveScore = self.classScoreInfo.haveScore
			scoreList = self.classScoreInfo.scoreList
		end

		if scoreList == nil or #scoreList ~= #self.scoreItemList then
			error("sr_精品课程  ExcellentClassView:UpdataExcellentClassTask()    请检查积分奖励配置 = ", #self.scoreItemList)

			return
		end

		local itemCount = #scoreList
		local jd = 0

		self.nowScoreTxt.text = tostring(haveScore)

		for i = 1, itemCount do
			if scoreList[i].isReceive then
				if self.scoreEffList[i] then
					UIEffectManager.instance:stopEffect(self.scoreEffList[i])

					self.scoreEffList[i] = nil
				end

				self.scoreItemList[i].receiveShowGo:SetActive(true)
				self.scoreItemList[i].itemBtnGo:SetActive(false)
				self.scoreItemList[i].satisfyIma:SetState(1)

				if jd < i then
					jd = i
				end
			elseif haveScore >= scoreList[i].score then
				self.scoreItemList[i].receiveShowGo:SetActive(false)
				self.scoreItemList[i].itemBtnGo:SetActive(true)

				if self.scoreEffList[i] == nil then
					local effPath = "fx_ui_longchengmibao/fx_ui_longchengmibao.prefab"
					local effRtts = self.scoreItemList[i].itemBtnGo:GetComponent(goutil.Type_RectTransform)

					self.scoreEffList[i] = UIEffectManager.instance:playEffect(self, effPath, self.scoreItemList[i].itemGo, 0, 0, true, nil, nil, function(self, uiEff)
						uiEff:setClipping(effRtts)

						local modGo = uiEff.effGo.transform:Find("ani_fx_ui_huoyuedu/mod_glow_1")

						if modGo then
							modGo.gameObject:SetActive(false)
						end
					end)

					self.scoreEffList[i]:setParent(self.scoreItemList[i].itemGo.transform)
					self.scoreEffList[i]:setLocalPos(0, 22, 0)
					self.scoreEffList[i]:setScale(0.6)
				end

				self.scoreItemList[i].satisfyIma:SetState(1)

				if jd < i then
					jd = i
				end
			else
				if self.scoreEffList[i] then
					UIEffectManager.instance:stopEffect(self.scoreEffList[i])

					self.scoreEffList[i] = nil
				end

				self.scoreItemList[i].receiveShowGo:SetActive(false)
				self.scoreItemList[i].itemBtnGo:SetActive(false)
				self.scoreItemList[i].satisfyIma:SetState(0)
			end
		end

		if itemCount <= jd then
			self.goodsBarSli.value = 1
		elseif jd < 1 then
			self.goodsBarSli.value = haveScore / (itemCount * scoreList[1].score)
		else
			local sy = haveScore - scoreList[jd].score
			local yy = scoreList[jd + 1].score - scoreList[jd].score

			self.goodsBarSli.value = jd / itemCount + sy / (itemCount * yy)
		end
	end

	if self.titleBtnList and #self.titleBtnList >= 1 then
		for i = 1, #self.titleBtnList do
			if self.titleBtnList[i] and self.titleBtnList[i].itemGo then
				local isRedPoint = SevenDaysModel.instance:GetClassTaskRedPoint(self.curActId, i)

				self.titleBtnList[i].titleRedPointGo:SetActive(isRedPoint)
			end
		end
	end

	self:ClickViewTitleBtn(self.choTitleNum, true)
end

function ExcellentClassView:SetPower2Update()
	if not self.curActId then
		return
	end

	SevenDaysController.instance:CSRequestClassInfo(self.curActId)
end

return ExcellentClassView
