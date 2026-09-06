-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionSendRedPackPetSelectView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionSendRedPackPetSelectView", package.seeall)

local GoddessCompetitionSendRedPackPetSelectView = class("GoddessCompetitionSendRedPackPetSelectView", ViewComponent)

function GoddessCompetitionSendRedPackPetSelectView:buildUI()
	GoddessCompetitionSendRedPackPetSelectView.super.buildUI(self)

	self._btnCloseSelect = self:getGo("btnCloseSelect")
	self._selectTableView = self:getGo("selectTableView")
	self._selectTableCell = self:getGo("selectTableView/selectTableCell")
	self._selectTableList = ScrollerList.create(self._selectTableView, self._selectTableCell, GameUtil.handler(self._updateSelectCell, self), GameUtil.handler(self._clearSelectCell, self))
end

function GoddessCompetitionSendRedPackPetSelectView:bindEvents()
	GoddessCompetitionSendRedPackPetSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCloseSelect, self.close, self)
end

function GoddessCompetitionSendRedPackPetSelectView:unbindEvents()
	GoddessCompetitionSendRedPackPetSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCloseSelect)
end

function GoddessCompetitionSendRedPackPetSelectView:onEnter()
	GoddessCompetitionSendRedPackPetSelectView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stepId = checknumber(params[2])

	self:_refreshSelect()
end

function GoddessCompetitionSendRedPackPetSelectView:onExit()
	GoddessCompetitionSendRedPackPetSelectView.super.onExit(self)
	self._selectTableList:dispose()
end

function GoddessCompetitionSendRedPackPetSelectView:_refreshSelect()
	local list = GoddessCompetitionModel.instance:getCurGoddessList(self._stepId)
	local dataList = {}

	for _, info in ipairs(list) do
		table.insert(dataList, info)
	end

	table.sort(dataList, function(a, b)
		local sortIdA = GoddessCompetitionConfig.instance:getGoddessSortId(self._activityId, a.faceId)
		local sortIdB = GoddessCompetitionConfig.instance:getGoddessSortId(self._activityId, b.faceId)

		return sortIdA < sortIdB
	end)
	self._selectTableList:reloadData(dataList)
end

function GoddessCompetitionSendRedPackPetSelectView:_updateSelectCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local con = goutil.findChild(go, "con/icon")
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(data.faceId))

	if not modelCo then
		printError("t_model id not exist:" .. data.faceId)

		return
	end

	uGuiUtil.clearImage(con)
	uGuiUtil.setSpriteToImage(con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	GameUtil.addClickHandler(go, function()
		self:_onClickSelectPet(data.faceId)
	end)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(data.faceId)

	txtName.text = skinCfg.skinName
end

function GoddessCompetitionSendRedPackPetSelectView:_clearSelectCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con/icon")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(go)
end

function GoddessCompetitionSendRedPackPetSelectView:_onClickSelectPet(goddessId)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCompetitionSelectGoddess, {
		goddessId = goddessId
	})
	self:close()
end

return GoddessCompetitionSendRedPackPetSelectView
