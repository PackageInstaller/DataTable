-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/dreamteammutualhelp/DreamteammutualhelpView.lua

module("logic.extensions.scenariocopy.view.dreamteammutualhelp.DreamteammutualhelpView", package.seeall)

local DreamteammutualhelpView = class("DreamteammutualhelpView", FatherDungeonView)

function DreamteammutualhelpView:ctor()
	DreamteammutualhelpView.super.ctor(self)
end

function DreamteammutualhelpView:_getChapterMaxNum()
	return 1
end

function DreamteammutualhelpView:_getStageMaxNum()
	return 6
end

function DreamteammutualhelpView:_getIndexRange()
	return 4, 4
end

function DreamteammutualhelpView:_getStageViewName()
	return ViewName.DreamteammutualhelpStageView
end

function DreamteammutualhelpView:onEnterFinished()
	local firstParam = self:getFirstParam()

	if firstParam == nil or firstParam ~= "showInTab" then
		self:close()
		UIStateManager.instance:push(ViewName.DreamyouthView, "dreamteammutualhelpview")

		return
	end

	ScenariocopyController.instance:markDreamyouthShowRedPoint()
	DreamteammutualhelpView.super.onEnterFinished(self)
end

DreamteammutualhelpView.MODEL = {
	"btn_zmsnny_08",
	"btn_zmsnny_06",
	"btn_zmsnny_07",
	"btn_zmsnny_04",
	"btn_zmsnny_05",
	"10140"
}

function DreamteammutualhelpView:buildUI()
	DreamteammutualhelpView.super.buildUI(self)

	self._dreamTeamModel = {}
	self._icon = {}
end

function DreamteammutualhelpView:onExit()
	DreamteammutualhelpView.super.onExit(self)

	for i, v in ipairs(self._dreamTeamModel) do
		if i == #DreamteammutualhelpView.MODEL then
			RoleObjectPool.instance:removeRole(v)
		elseif v then
			uGuiUtil.clearImage(v)
		end
	end

	for i, rewardIcon in pairs(self._icon) do
		if rewardIcon then
			uGuiUtil.clearImage(rewardIcon)
		end
	end
end

function DreamteammutualhelpView:_updateLevelCellSpec(go, i, typeId, plotChapterCfg)
	DreamteammutualhelpView.super._updateLevelCellSpec(self, go, i, typeId, plotChapterCfg)

	local con = goutil.findChild(go, "con")

	if i == #DreamteammutualhelpView.MODEL then
		if self._dreamTeamModel[i] then
			RoleObjectPool.instance:removeRole(self._dreamTeamModel[i])
		end

		self._dreamTeamModel[i] = RoleObjectPool.instance:addRoleToParent(self._dreamTeamModel[i], checknumber(DreamteammutualhelpView.MODEL[i]), con, 0.8, nil, nil, 0, -100)
	else
		if self._dreamTeamModel[i] then
			uGuiUtil.clearImage(self._dreamTeamModel[i])
		end

		self._dreamTeamModel[i] = con

		uGuiUtil.setSpriteToImage(self._dreamTeamModel[i], nil, GameUrl.getIconFolderUrl("dreamyouth", DreamteammutualhelpView.MODEL[i]))
	end

	local curStageCfg = ScenariocopyConfig.instance:getStageCfg(plotChapterCfg.chapterId, 1)
	local reward = goutil.findChild(go, "reward")
	local rewardIcon = goutil.findChild(go, "reward/txtCost/icon")
	local txt = goutil.findChildTextComponent(go, "reward/txtCost")

	if not string.nilorempty(curStageCfg.comReward) then
		goutil.setActive(reward, true)

		local arr = string.split(curStageCfg.comReward, ":")

		if self._icon[i] then
			uGuiUtil.clearImage(self._icon[i])
		end

		self._icon[i] = rewardIcon

		uGuiUtil.setSpriteToImage(rewardIcon, uGuiUtil.SpriteType.BigBg, self:getCoinIconUrl(arr[1], arr[2]))

		if arr[3] then
			txt.text = "x" .. arr[3] or ""
		end
	else
		goutil.setActive(reward, false)
	end
end

function DreamteammutualhelpView:getCoinIconUrl(type, id)
	local iconUrl = ""
	local cfg = MaterialMgr.getMatCfg(type, id)

	if cfg then
		local icon = cfg.icon

		iconUrl = GameUrl.getItemIconUrl(icon)
	end

	return iconUrl
end

return DreamteammutualhelpView
