-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/TargetColCell.lua

module("logic.extensions.powerland.view.TargetColCell", package.seeall)

local TargetColCell = class("TargetColCell", CustomRightCell)

TargetColCell.prefabUrl = "ui/views/powerland/targetcolview.prefab"
TargetColCell.posArrList_Fmt = {
	{
		-20,
		0,
		1
	},
	{
		20,
		0,
		1
	}
}

function TargetColCell:buildUI()
	self._targetCol = goutil.findChild(self.mainGO, "targetCol")
	self._targetView = goutil.findChild(self.mainGO, "targetCol/targetView")
	self._targetCell = goutil.findChild(self.mainGO, "targetCol/targetCell")

	GameUtil.SetActive(self._targetCell, false)
end

function TargetColCell:onUpdateTargetCol(targetIds)
	local targetCount = #targetIds
	local children = GameUtil.getChildren(self._targetView)

	for idx, targetId in ipairs(targetIds) do
		if not children[idx] then
			local mainGo = goutil.cloneAndSetParent(self._targetCell, self._targetView.transform)
			local targetIcon = goutil.findChild(mainGo, "icon")

			mainGo.name = string.format("targetCell_%d", idx)

			local targetData
			local battleTargetInfo = PowerLandModel.instance:getBattleTargetInfo()
			local level = battleTargetInfo:getTargetLevel(targetId)
			local targetData = PowerLandConfig.instance:getRealPlTargetData(targetId, level)

			if targetIcon then
				local path = targetData.iconPath
				local bgGo = targetIcon

				if not string.nilorempty(path) and bgGo then
					local spriteType = uGuiUtil.SpriteType.BigBg
					local spriteName = string.format("ui/icon/expevents/%s.png", path)

					local function func()
						return
					end

					uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
				end
			else
				printError(string.format("助战精灵id%d,对应印记的预制无法寻到.( idx=%d )", data.creepsId, idx))
			end
		end
	end

	for i = 1, self._targetView.transform.childCount do
		local trans = self._targetView.transform:GetChild(i - 1)
		local mainGo = trans.gameObject

		GameUtil.SetActive(mainGo, i <= targetCount)
	end
end

function TargetColCell:clearTargetCol()
	for i = 1, self._targetView.transform.childCount do
		local trans = self._targetView.transform:GetChild(i - 1)
		local mainGo = trans.gameObject
		local targetIcon = goutil.findChild(mainGo, "icon")

		uGuiUtil.clearImage(targetIcon)
	end
end

function TargetColCell:setTargetCellPos(posArrList)
	for idx, posArr in ipairs(posArrList) do
		local trans = self._targetView.transform:GetChild(idx - 1)
		local mainGO = trans.gameObject

		if mainGO == nil then
			printError("缺少预制体")

			return
		end

		local x, y, scale = posArr[1], posArr[2], posArr[3]

		GameUtil.setLocalPos(mainGO, x, y, 1)
		GameUtil.setLocalScale(mainGO, scale)
	end
end

return TargetColCell
