-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\PVP\\TopPvpRankBillBoard.lua

local HeadHelper = require("UI/RoleInfo/HeadHelper")
local imageType = typeof(UnityEngine.UI.Image)
local labelType = typeof(UnityEngine.UI.Text)
local controllerType = typeof(Framework.UI.UIController)
local TopPvpRankBillBoard = Class("TopPvpRankBillBoard")

function TopPvpRankBillBoard:ctor(...)
	return
end

function TopPvpRankBillBoard:initBillBoard(...)
	self.bbGO = UnityEngine.GameObject.Find("wj_jjc_xianshipai_01")

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

	for i = 1, 4 do
		local imgTransform = uiRootTran:Find("Head" .. i)
		local head = imgTransform:GetComponent(imageType)

		self.headImgs[i] = head

		local txtTransform = uiRootTran:Find("PlayerName" .. i)
		local name = txtTransform:GetComponent(labelType)

		self.nameTxts[i] = name
	end
end

function TopPvpRankBillBoard:clear()
	self.bbGO = nil
end

function TopPvpRankBillBoard:setRankDisplay()
	if not self.bbGO or not CurAvatar then
		return
	end

	local pvpData = CurAvatar.cachedTopPvpRankData

	if not pvpData or #pvpData == 0 then
		self.bbGO:SetActive(false)

		return
	else
		local bbGO = UnityEngine.GameObject.Find("wj_jjc_xianshipai")

		if bbGO then
			bbGO:SetActive(false)
		end
	end

	local actobj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_TOPPVP)

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_TOPPVP) or actobj and actobj.inOpening == true then
		self.bbGO:SetActive(false)

		return
	end

	self.bbGO:SetActive(true)

	local uiRootTran = self.bbGO.transform:Find("Canvas")

	if uiRootTran then
		uiRootTran.gameObject:SetActive(true)
	end

	for i = 1, 4 do
		local uiHead = self.headImgs[i]
		local uiName = self.nameTxts[i]
		local comData = pvpData[i].comm

		if not comData or not comData.uid then
			uiHead.enabled = false
			uiName.enabled = false
		else
			uiHead.enabled = true
			uiName.enabled = true

			local uid = comData.uid

			if uid and self.uiController then
				local headId = comData.head or 1
				local name = comData.name or Lang.get(29958)

				HeadHelper.setHeadIconWithUnityType(self.uiController, uiHead, headId, comData.uid)

				local playerName, svrName = utils.GetPlayerName(name, uid)

				uiName.text = playerName
			end
		end
	end
end

return TopPvpRankBillBoard
