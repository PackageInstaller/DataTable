-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/petskinsell/PetSkinGotoView.lua

module("logic.extensions.firstcharge.view.petskinsell.PetSkinGotoView", package.seeall)

local PetSkinGotoView = class("PetSkinGotoView", ViewComponent)

function PetSkinGotoView:buildUI()
	PetSkinGotoView.super.buildUI(self)

	self._goBg = self:getGo("bg")
	self._goRole = self:getGo("role")
	self._goSlogan1 = self:getGo("slogan_1")
	self._goSlogan2 = self:getGo("slogan_2")
	self._goBtnSkill = self:getGo("btnSkill")
	self._goCellTab = self:getGo("cellTab")
	self._goTableviewTab = self:getGo("tableviewTab")
	self._goBtnGoto = self:getGo("btnGoto")
	self._txtGoto = goutil.findChildTextComponent(self._goBtnGoto, "txt")
	self._btnClose = self:getBtn("btnClose")
	self._txtTime = self:getTxt("txtTime")
	self._petPhoto = PetPhotoShow.Get(self._goRole)
	self._tableviewTab = ScrollerList.create(self._goTableviewTab, self._goCellTab, GameUtil.handler(self._updateCellTab, self), GameUtil.handler(self._clearCellTab, self))
end

function PetSkinGotoView:onEnter()
	PetSkinGotoView.super.onEnter(self)
	self:_updateViewByCfg()
end

function PetSkinGotoView:bindEvents()
	PetSkinGotoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._goBtnSkill, GameUtil.handler(self._onClickSkill, self))
	GameUtil.addClickHandler(self._goBtnGoto, GameUtil.handler(self._onClickGoto, self))
	self._btnClose:AddClickListener(self.close, self)
end

function PetSkinGotoView:unbindEvents()
	PetSkinGotoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._goBtnSkill)
	GameUtil.rmClickHandler(self._goBtnGoto)
	self._btnClose:RemoveClickListener()
end

function PetSkinGotoView:onExit()
	PetSkinGotoView.super.onExit(self)
	self:_resetView()
end

function PetSkinGotoView:_clearCellTab(goCell)
	local cell = {}

	cell.go = goCell

	GameUtil.rmClickHandler(cell.go)

	cell.redPoint = goutil.findChild(cell.go, "redPoint")
	cell.selected = goutil.findChild(cell.go, "selected")

	goutil.setActive(cell.redPoint, false)
	uGuiUtil.clearImage(cell.go)

	return cell
end

function PetSkinGotoView:_updateCellTab(view, goCell, data)
	local cell = self:_clearCellTab(goCell)

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._switchTab, self, data))
	goutil.setActive(cell.selected, self._selectData == data)
	self:_setImgRes(cell.go, data.tabImg)

	local dateKey = "Skin_Goto_Data_Key_" .. data.id
	local isShow = checknumber(GameUtil.getUserDayData(dateKey)) <= 0

	goutil.setActive(cell.redPoint, isShow)
end

function PetSkinGotoView:_switchTab(data)
	if self._selectData ~= data then
		self._selectData = data

		FirstChargeController.instance:updateSkinGotoRedPointData(data.id)
		self:_updateViewByTab()
		self._tableviewTab:reloadData(self.curTabDataList)
	end
end

function PetSkinGotoView:_onClickGoto()
	if self._selectData then
		if not string.nilorempty(self._selectData) then
			self:close()
			GotoMgr.gotoByString(self._selectData)
		else
			goutil.setActive(self._goBtnGoto, false)
		end
	end
end

function PetSkinGotoView:_onClickSkill()
	if self._selectData then
		local petSkinId = self._selectData.skinId
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(petSkinId)

		if skinCfg then
			PetbookController.instance:previewBattle(skinCfg.raceId, petSkinId)
		else
			goutil.setActive(self._goBtnSkill, false)
		end
	end
end

function PetSkinGotoView:_updateViewByCfg()
	self._selectData = nil

	local actCfgs = PetSkinConfig.instance:getCurActPetSkinGotoCfgs()

	self.curTabDataList = {}

	if #actCfgs > 0 then
		self.lastEndTime = GameUtil.string2time(actCfgs[1].endTime)

		for k, v in ipairs(actCfgs) do
			local endTime = GameUtil.string2time(v.endTime)

			if endTime < self.lastEndTime then
				self.lastEndTime = endTime
			end

			table.insert(self.curTabDataList, v)
		end

		goutil.setActive(self._goTableviewTab, #self.curTabDataList > 1)
		self:_switchTab(actCfgs[1])
		goutil.setActive(self._txtTime.gameObject, true)
		settimer(1, self._updatePerSec, self)
	else
		FloatWordMgr.instance:show(lang("当前活动已结束"))
		self:close()
	end
end

function PetSkinGotoView:_updateViewByTab()
	self:_loadResByData(self._selectData)
	self:_setOthersByData(self._selectData)
	self:_setPosByData(self._selectData)
	self:_updatePerSec()
end

function PetSkinGotoView:_loadResByData(data)
	if not data then
		return
	end

	self:_setImgRes(self._goBg, data.bgImg)
	self:_setImgRes(self._goSlogan1, data.sloganImg1)
	self:_setImgRes(self._goSlogan2, data.sloganImg2)
end

function PetSkinGotoView:_setImgRes(imgGo, path)
	if goutil.isNil(imgGo) then
		return
	end

	local img = imgGo:GetComponent(goutil.Type_UIImage)

	img.enabled = false

	if string.nilorempty(path) then
		return
	end

	local resPath = string.format("ui/bigbg/bgskin/%s.png", path)

	uGuiUtil.setSpriteToImage(imgGo, uGuiUtil.SpriteType.BigBg, resPath, function()
		img:SetNativeSize()

		img.enabled = true
	end)
end

function PetSkinGotoView:_setPosByData(data)
	if not data then
		return
	end

	self:_setAnchoPos(self._goBtnSkill, data.btnSkillPos)
	self:_setAnchoPos(self._goBtnGoto, data.btnGotoPos)
	self:_setAnchoPos(self._goRole, data.rolePos)
	self:_setAnchoPos(self._goBg, data.bgPos)
	self:_setAnchoPos(self._goSlogan1, data.sloganPos1)
	self:_setAnchoPos(self._goSlogan2, data.sloganPos2)
	self:_setAnchoPos(self._txtTime.gameObject, data.txtTimePos)
end

function PetSkinGotoView:_setAnchoPos(go, pos)
	if goutil.isNil(go) then
		return
	end

	local posSet = pos or {
		0,
		0
	}

	GameUtil.setAnchoredPos(go, posSet[1], posSet[2])
end

function PetSkinGotoView:_setOthersByData(data)
	if not data then
		return
	end

	goutil.setActive(self._goBtnGoto, not string.nilorempty(data.gotoParam))

	local skinId = data.skinId
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if skinCfg then
		goutil.setActive(self._goBtnSkill, true)
		self:_setRoleSpine(data)
	else
		goutil.setActive(self._goBtnSkill, false)
		goutil.setActive(self._goRole, false)
	end

	self._txtGoto.text = langPara("点击前往")

	if not string.nilorempty(data.btnGotoTip) then
		self._txtGoto.text = data.btnGotoTip
	end
end

function PetSkinGotoView:_setRoleSpine(data)
	goutil.setActive(self._goRole, false)

	local isShowRole = data.isShowRole

	if isShowRole then
		if self._petPhoto then
			self._petPhoto:clear()
		end

		self._petPhoto:showPetEffect(data.skinId, true, data.camScale)
		goutil.setActive(self._goRole, true)
	end
end

function PetSkinGotoView:_resetView()
	goutil.setActive(self._goBtnSkill, false)
	goutil.setActive(self._goBtnGoto, false)
	goutil.setActive(self._txtTime.gameObject, false)
	removetimer(self._updatePerSec, self)

	if self._petPhoto then
		self._petPhoto:clear()
	end

	goutil.setActive(self._goRole, false)
	uGuiUtil.clearImage(self._goBg)
	uGuiUtil.clearImage(self._goSlogan1)
	uGuiUtil.clearImage(self._goSlogan2)
end

function PetSkinGotoView:_updatePerSec()
	if not self._selectData then
		return self:close()
	end

	local timeNow = ServerTime.now()

	if timeNow >= self.lastEndTime then
		FloatWordMgr.instance:show(lang("活动刷新"))
		self:_updateViewByCfg()
	end

	local leftTime = GameUtil.string2time(self._selectData.endTime) - timeNow

	self._txtTime.text = GameUtil.FormatTimeSymbol(leftTime)
end

return PetSkinGotoView
