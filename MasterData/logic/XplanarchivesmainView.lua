-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xplanarchives/view/XplanarchivesmainView.lua

module("logic.extensions.xplanarchives.view.XplanarchivesmainView", package.seeall)

local XplanarchivesmainView = class("XplanarchivesmainView", ViewComponent)

function XplanarchivesmainView:ctor()
	XplanarchivesmainView.super.ctor(self)
end

function XplanarchivesmainView:unbindEvents()
	XplanarchivesmainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btn2:RemoveClickListener()
	self._btn1:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function XplanarchivesmainView:bindEvents()
	XplanarchivesmainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnReward:AddClickListener(self._onClickbtnReward, self)
	self._btn2:AddClickListener(self._onClickbtn2, self)
	self._btn1:AddClickListener(self._onClickbtn1, self)
	self._btnLeft:AddClickListener(self._onClickbtnLeft, self)
	self._btnRight:AddClickListener(self._onClickbtnRight, self)
end

function XplanarchivesmainView:buildUI()
	XplanarchivesmainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnReward = self:getBtn("btnReward")
	self._btn2 = self:getBtn("btn2")
	self._btn1 = self:getBtn("btn1")
	self._page1Go = self:getGo("page1")
	self._page2Go = self:getGo("page2")
	self._btnLeft = self:getBtn("btnLeft")
	self._btnRight = self:getBtn("btnRight")
	self._redpointGoRight = self:getGo("btnRight/redpoint")
	self._redpointGoLeft = self:getGo("btnLeft/redpoint")
	self._btn1Change = self:getGo("btn1"):GetComponent(ComponentType.UIChangeGroup)
	self._btn2Change = self:getGo("btn2"):GetComponent(ComponentType.UIChangeGroup)

	goutil.setActive(self._page1Go, false)
	goutil.setActive(self._page2Go, false)

	self._pageItems = {}

	goutil.setActive(self._redpointGoRight, false)
	goutil.setActive(self._redpointGoLeft, false)

	self._redpointGo = self:getGo("btnReward/redpoint")
	self._goldconGo = self:getGo("goldcon")
end

function XplanarchivesmainView:onExit()
	XplanarchivesmainView.super.onExit(self)

	for _, v in pairs(self._pageItems) do
		if v.pageType == 1 then
			local goIcon = goutil.findChild(v.mainGO, "icon")

			uGuiUtil.clearImage(goIcon)
		else
			local goCon = goutil.findChild(v.mainGO, "con")

			for i = 1, goCon.transform.childCount do
				local go = goCon.transform:GetChild(i - 1).gameObject
				local goIcon = goutil.findChild(go, "icon")

				uGuiUtil.clearImage(goIcon)
			end
		end
	end

	RedPointController.instance:unregRedPoint(self._redpointGo)
end

function XplanarchivesmainView:onEnter()
	XplanarchivesmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.XPlanArchivesInfoRes, self._update, self)
	self.addGEvent(self, GlobalNotify.XPlanArchivesFinishRes, self._update, self)
	self.addGEvent(self, GlobalNotify.XPlanArchivesFinishRes, self._update, self)

	self._tabId = 1
	self._curPage = 1

	self:_setActId()

	if self._activityId <= 0 then
		printError("活动id错误")
		self:close()

		return
	end

	self:_setSpeMainTopGoldBar()
	RedPointController.instance:regRedPoint(self._redpointGo, 584)
	XPlanArchivesAgent.instance:sendPM_XPlanArchivesInfoReq(self._activityId)
end

function XplanarchivesmainView:_update()
	self:_updateData()
	self:_updateUI()
end

function XplanarchivesmainView:_updateData()
	self._tabCfgs = XplanarchivesConfig.instance:getPageCfgs(self._activityId)
	self._maxPage = self:_toNearestOdd(#self._tabCfgs[self._tabId])
end

function XplanarchivesmainView:_updateUI()
	self._btn1Change:SetState(self._tabId == 1 and 0 or 1)
	self._btn2Change:SetState(self._tabId == 2 and 0 or 1)
	self:_buildPages()
	self:_setPageData()
	self:_updateRed()
	self:_setNextBtnState()
end

function XplanarchivesmainView:_onClickbtnClose()
	self:close()
end

function XplanarchivesmainView:_onClickbtnReward()
	UIStateManager.instance:push(ViewName.XplanarchivesrewardView, self._activityId)
end

function XplanarchivesmainView:_onClickbtn2()
	self._tabId = 2
	self._curPage = 1

	self:_update()
end

function XplanarchivesmainView:_onClickbtn1()
	self._tabId = 1
	self._curPage = 1

	self:_update()
end

function XplanarchivesmainView:_onClickbtnLeft()
	self._curPage = self._curPage - 2
	self._curPage = math.max(self._curPage, 1)

	self:_updateUI()
end

function XplanarchivesmainView:_onClickbtnRight()
	self._curPage = self._curPage + 2
	self._curPage = math.min(self._curPage, self._maxPage)

	self:_updateUI()
end

function XplanarchivesmainView:_setActId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.XplanArchives)
	end
end

function XplanarchivesmainView:_buildPages()
	local tabCfgs = self._tabCfgs[self._tabId]
	local items = self._pageItems

	self._pageItems = {}

	for i, v in ipairs(items) do
		goutil.setActive(v.mainGO, false)
	end

	for page = self._curPage, self._curPage + 1 do
		local cfg = tabCfgs[page]

		if cfg then
			local item

			for i = #items, 1, -1 do
				if items[i].pageType == cfg.pageType then
					item = table.remove(items, i)

					break
				end
			end

			if not item then
				local mainGO = cfg.pageType == 1 and goutil.cloneAndSetParent(self._page1Go, self.mainGO.transform) or goutil.cloneAndSetParent(self._page2Go, self.mainGO.transform)

				item = {
					pageType = cfg.pageType,
					mainGO = mainGO
				}
			end

			item.viewCfgs = XplanarchivesConfig.instance:getViewCfgs(self._activityId, self._tabId, page)

			goutil.setActive(item.mainGO, true)

			local x = 0

			x = cfg.pageType == 1 and (page - self._curPage == 0 and -225 or 275) or page - self._curPage == 0 and -225 or 275

			Framework.TransformUtil.SetLocalPos(item.mainGO.transform, x, -33, 0)
			table.insert(self._pageItems, item)
		end
	end

	for i, v in ipairs(items) do
		goutil.destroy(v.mainGO)
	end
end

function XplanarchivesmainView:_setPageData()
	for i, v in ipairs(self._pageItems) do
		if v.pageType == 1 then
			local txtDesc = goutil.findChildTextComponent(v.mainGO, "txtDesc")
			local txtTitle = goutil.findChildTextComponent(v.mainGO, "txtTitle")
			local btnMask = Framework.ButtonAdapter.GetFrom(v.mainGO, "mask")
			local txtMaskDesc = goutil.findChildTextComponent(v.mainGO, "mask/txtDesc")
			local goIcon = goutil.findChild(v.mainGO, "icon")
			local viewCfg = v.viewCfgs[1]
			local curId = self:_getCurIdByType(viewCfg.typeId)
			local isUnlock = curId >= viewCfg.prizeId
			local isCurUnlock = curId + 1 == viewCfg.prizeId
			local hasIcon = not string.nilorempty(viewCfg.icon)

			goutil.setActive(btnMask.gameObject, not isUnlock)
			goutil.setActive(goIcon, hasIcon)

			txtDesc.text = viewCfg.desc
			txtTitle.text = viewCfg.title

			if isCurUnlock then
				local typeCfg = XplanarchivesConfig.instance:getTypeCfg(self._activityId, viewCfg.typeId)
				local matName = MaterialMgr.getMaterialsNameByCfg(typeCfg.costItemType)
				local typePrizeCfg = XplanarchivesConfig.instance:getTypePrizeCfg(self._activityId, viewCfg.typeId, viewCfg.prizeId)
				local matNum = typePrizeCfg.needNumber

				txtMaskDesc.text = string.format("消耗【%s】x%s解锁该档案", matName, matNum)
			else
				txtMaskDesc.text = "需要解锁上一个档案"
			end

			if hasIcon then
				uGuiUtil.setSpriteToImage(goIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(viewCfg.icon))
			end

			btnMask:AddClickListener(function()
				if not isUnlock and not isCurUnlock then
					FloatWordMgr.instance:show("先解锁前面的档案")

					return
				end

				if isUnlock then
					return
				end

				local prizeCfg = XplanarchivesConfig.instance:getTypePrizeCfg(self._activityId, viewCfg.typeId, viewCfg.prizeId)

				if not self:_checkEnough(viewCfg.typeId, prizeCfg.needNumber) then
					FloatWordMgr.instance:show("解锁道具不足")

					return
				end

				XPlanArchivesAgent.instance:sendPM_XPlanArchivesFinishReq(self._activityId, viewCfg.typeId, viewCfg.prizeId)
			end)
		else
			local goCon = goutil.findChild(v.mainGO, "con")
			local goCell = goutil.findChild(v.mainGO, "cell")
			local layout = goCon:GetComponent(ComponentType.UILayoutSingleLine)

			goutil.setActive(goCell, false)

			for i = 1, goCon.transform.childCount do
				local go = goCon.transform:GetChild(i - 1).gameObject

				goutil.setActive(go, false)
			end

			for i = goCon.transform.childCount + 1, #v.viewCfgs do
				local go = goutil.cloneAndSetParent(goCell, goCon.transform)

				goutil.setActive(go, true)
			end

			for i, viewCfg in ipairs(v.viewCfgs) do
				local go = goCon.transform:GetChild(i - 1).gameObject

				goutil.setActive(go, true)

				local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
				local btnMask = Framework.ButtonAdapter.GetFrom(go, "mask")
				local txtMaskDesc = goutil.findChildTextComponent(go, "mask/txt")
				local goIcon = goutil.findChild(go, "icon")
				local curId = self:_getCurIdByType(viewCfg.typeId)
				local isUnlock = curId >= viewCfg.prizeId
				local isCurUnlock = curId + 1 == viewCfg.prizeId
				local hasIcon = not string.nilorempty(viewCfg.icon)

				goutil.setActive(goIcon, hasIcon)
				goutil.setActive(btnMask.gameObject, not isUnlock)

				if not string.nilorempty(viewCfg.icon) then
					uGuiUtil.setSpriteToImage(goIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(viewCfg.icon))
				end

				txtDesc.text = viewCfg.desc

				if isCurUnlock then
					local typeCfg = XplanarchivesConfig.instance:getTypeCfg(self._activityId, viewCfg.typeId)
					local matName = MaterialMgr.getMaterialsNameByCfg(typeCfg.costItemType)
					local typePrizeCfg = XplanarchivesConfig.instance:getTypePrizeCfg(self._activityId, viewCfg.typeId, viewCfg.prizeId)
					local matNum = typePrizeCfg.needNumber

					txtMaskDesc.text = string.format("消耗【%s】x%s解锁该档案", matName, matNum)
				else
					txtMaskDesc.text = "需要解锁上一个档案"
				end

				btnMask:AddClickListener(function()
					if not isUnlock and not isCurUnlock then
						FloatWordMgr.instance:show("先解锁前面的档案")

						return
					end

					if isUnlock then
						return
					end

					local prizeCfg = XplanarchivesConfig.instance:getTypePrizeCfg(self._activityId, viewCfg.typeId, viewCfg.prizeId)

					if not self:_checkEnough(viewCfg.typeId, prizeCfg.needNumber) then
						FloatWordMgr.instance:show("解锁道具不足")

						return
					end

					XPlanArchivesAgent.instance:sendPM_XPlanArchivesFinishReq(self._activityId, viewCfg.typeId, viewCfg.prizeId)
				end)
			end

			layout:Layout()
		end
	end
end

function XplanarchivesmainView:_getCurIdByType(typeId)
	local info = XplanarchivesModel.instance:getInfo(self._activityId)

	for i, v in ipairs(info.types) do
		if v.typeId == typeId then
			return v.curId
		end
	end

	return 0
end

function XplanarchivesmainView:_checkEnough(typeId, needNumber)
	local typeCfg = XplanarchivesConfig.instance:getTypeCfg(self._activityId, typeId)
	local str = typeCfg.costItemType .. ":" .. needNumber

	return MaterialMgr.getMatEnough(str)
end

function XplanarchivesmainView:_toNearestOdd(n)
	if n % 2 == 1 then
		return n
	else
		return n - 1
	end
end

function XplanarchivesmainView:_setNextBtnState()
	goutil.setActive(self._btnLeft.gameObject, self._curPage > 1)
	goutil.setActive(self._btnRight.gameObject, self._curPage < self._maxPage and self._maxPage > 1)
end

function XplanarchivesmainView:_setSpeMainTopGoldBar()
	local btn_list = {}
	local cfg = XplanarchivesConfig.instance:getActCfg(self._activityId)
	local list = string.split(cfg.mats, "#")

	for i, v in ipairs(list) do
		table.insert(btn_list, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldconGo, self._viewPresentor, btn_list, false)
end

function XplanarchivesmainView:_updateRed()
	local leftDot = false
	local rightDot = false

	if self._curPage > 1 then
		for page = 1, self._curPage - 1 do
			if self:_checkUnlockEnough(page) then
				leftDot = true

				break
			end
		end
	end

	if self._curPage < self._maxPage and self._maxPage > 1 then
		for page = self._curPage + 2, self._maxPage do
			if self:_checkUnlockEnough(page) then
				rightDot = true

				break
			end
		end
	end

	goutil.setActive(self._redpointGoLeft, leftDot)
	goutil.setActive(self._redpointGoRight, rightDot)
end

function XplanarchivesmainView:_checkUnlockEnough(page)
	local pageCfg = XplanarchivesConfig.instance:getPageCfg(self._activityId, self._tabId, page)
	local tempViewCfgs = XplanarchivesConfig.instance:getViewCfgs(self._activityId, self._tabId, page)

	for i, viewCfg in ipairs(pageCfg.pageType == 1 and {
		tempViewCfgs[1]
	} or tempViewCfgs) do
		local curId = self:_getCurIdByType(viewCfg.typeId)

		if curId + 1 == viewCfg.prizeId then
			local typeCfg = XplanarchivesConfig.instance:getTypeCfg(self._activityId, viewCfg.typeId)
			local typePrizeCfg = XplanarchivesConfig.instance:getTypePrizeCfg(self._activityId, viewCfg.typeId, viewCfg.prizeId)
			local hasNum = MaterialMgr.getMatCount(typeCfg.costItemType)

			return hasNum >= typePrizeCfg.needNumber
		end
	end

	return false
end

return XplanarchivesmainView
