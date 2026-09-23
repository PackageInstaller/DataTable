local listType = RoleListType.Center
local selectID = nil

function Awake()
	layout = ComUtil.GetCom(vsv, "UIInfinite")
	layout:Init("UIs/RoleLittleCard/RoleLittleCard2", LayoutCallBack, true)
end

function LayoutCallBack(index)
	local lua = layout:GetItemLua(index)
	if(lua) then
		local _data = curDatas[index]
		lua.SetIndex(index)
		lua.SetClickCB(OnClickItemCB)
		lua.Refresh(_data, selectID, curID)
	end
end

function OnOpen()
	curID = data:GetID()
	
	RefreshPanel()
end

function RefreshPanel()
	SetTabData()
	SetDatas()
	ShowList()
end

--页签数据
function SetTabData()
	--升降
	orderType = RoleMgr:GetOrderType(listType)
	--local rota = orderType == RoleListOrderType.Up and 0 or 180
	--CSAPI.SetRectAngle(objSort, 0, 0, rota)
	--排序,筛选
	conditionData = RoleMgr:GetSortType(listType)
	local id = conditionData.Sort[1]
	local str = Cfgs.CfgRoleSortEnum:GetByID(id).sName or ""
	CSAPI.SetText(txtSort, str)
end

function SetDatas()
	datas = {}
	local arr = RoleMgr:GetArr()
	datas = RoleSortUtil:SortByCondition(listType, arr)
end

function ShowList()
	curDatas = {}
	if(orderType == RoleListOrderType.Up) then
		local len = #datas
		for k = len, 1, - 1 do
			table.insert(curDatas, datas[k])
		end
	else
		curDatas = datas
	end
	layout:IEShowList(#curDatas)
end

--点击卡牌
function OnClickItemCB(_index)
	if(selectID and selectID == curDatas[_index]:GetID()) then
		return
	end
	selectID = curDatas[_index]:GetID()
	layout:UpdateList()
end

function OnClickCancel()
	view:Close()
end

function OnClickSure()
	if(selectID and selectID ~= curID) then
		local _data = RoleMgr:GetData(selectID)
		EventMgr.Dispatch(EventType.Role_Card_ChangeResult, _data)
	end
	view:Close()
end

function OnClickMask()
	view:Close()
end

--上下
function OnClickUD()
	orderType = orderType == RoleListOrderType.Up and RoleListOrderType.Down or RoleListOrderType.Up
	RoleMgr:SetOrderType(listType, orderType)
	local rota = orderType == RoleListOrderType.Up and 0 or 180
	CSAPI.SetRectAngle(objSort, 0, 0, rota)
	ShowList()
end

--筛选
function OnClickFiltrate()
	local mData = {}
	--需要单选
	mData.single = {["Sort"] = 1} --1无意义
	--由上到下排序
	mData.list = {"Sort", "RoleTeam", "RoleQuality", "RolePosEnum"}--"RoleType", 
	--标题名(与list一一对应)
	mData.titles = {}
	-- for i = 3021, 3024 do
	-- 	table.insert(mData.titles, LanguageMgr:GetByID(i))
	-- end
	table.insert(mData.titles, LanguageMgr:GetByID(3021))
	table.insert(mData.titles, LanguageMgr:GetByID(3022))
	--table.insert(mData.titles, LanguageMgr:GetByID(3023))
	table.insert(mData.titles, LanguageMgr:GetByID(3024))
	table.insert(mData.titles, LanguageMgr:GetByID(3027))
	
	--当前数据
	mData.info = conditionData
	--源数据
	local _root = {}
	_root.Sort = "CfgRoleSortEnum"
	_root.RoleTeam = "CfgTeamEnum"
	--_root.RoleType = "CfgCore"
	_root.RoleQuality = "CfgCardQuality"
	_root.RolePosEnum = "CfgRolePosEnum"
	mData.root = _root
	--回调
	mData.cb = SortCB
	
	--卡牌排序类型  注意：非卡牌界面排序请注释 -------------------------------------
	mData.listType = listType
	
	CSAPI.OpenView("SortView", mData)
end
function SortCB(newInfo)
	conditionData = newInfo
	RoleMgr:SetSortType(listType, newInfo)
	RefreshPanel()
end
