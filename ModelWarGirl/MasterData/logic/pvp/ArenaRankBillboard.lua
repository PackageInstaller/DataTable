-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\PVP\\ArenaRankBillboard.lua

local HeadHelper = require("UI/RoleInfo/HeadHelper")
local imageType = typeof(UnityEngine.UI.Image)
local labelType = typeof(UnityEngine.UI.Text)
local controllerType = typeof(Framework.UI.UIController)
local ArenaRankBillBoard = Class("ArenaRankBillBoard")

function ArenaRankBillBoard:ctor(...)
	return
end

function ArenaRankBillBoard:initBillBoard(...)
	self.bbGO = UnityEngine.GameObject.Find("wj_jjc_xianshipai")

	if not self.bbGO then
		return
	end

	local uiRootTran = self.bbGO.transform:Find("Canvas")

	if uiRootTran then
		self.uiController = uiRootTran:GetComponent(controllerType)
	end

	self.headImgs = {}
	self.svrTxts = {}
	self.nameTxts = {}

	for i = 1, 3 do
		local imgTransform = uiRootTran:Find("Head" .. i)
		local head = imgTransform:GetComponent(imageType)

		self.headImgs[i] = head

		local txtTransform = uiRootTran:Find("PlayerName" .. i)
		local name = txtTransform:GetComponent(labelType)

		self.nameTxts[i] = name

		local svrTxtTransform = uiRootTran:Find("ServerName" .. i)
		local svrName = svrTxtTransform:GetComponent(labelType)

		self.svrTxts[i] = svrName
	end
end

function ArenaRankBillBoard:clear()
	self.bbGO = nil
end

function ArenaRankBillBoard:setRankDisplay()
	if not self.bbGO or not CurAvatar then
		return
	end

	local pvpData = CurAvatar:getOpactPvpTopThree()

	if not pvpData or #pvpData == 0 then
		self.bbGO:SetActive(false)

		return
	end

	self.bbGO:SetActive(true)

	for i = 1, 3 do
		local uiHead = self.headImgs[i]
		local uiName = self.nameTxts[i]
		local uiSvrName = self.svrTxts[i]
		local comData = pvpData[i]

		if not comData or not comData.uid then
			uiHead.enabled = false
			uiName.enabled = false
			uiSvrName.enabled = false
		else
			uiHead.enabled = true
			uiName.enabled = true
			uiSvrName.enabled = true

			local uid = comData.uid

			if uid and self.uiController then
				local headId = comData.head or 1
				local name = comData.name or Lang.get(29958)

				HeadHelper.setHeadIconWithUnityType(self.uiController, uiHead, headId, comData.uid)

				local playerName, svrName = utils.GetPlayerName(name, uid)

				uiName.text = playerName
				uiSvrName.text = svrName
			end
		end
	end
end

return ArenaRankBillBoard
