--设置人员入驻 data:MatrixData or DormRoomData
function OnInit()
	--UIUtil:AddTop2("MatrixSetRole", gameObject, function() view:Close() end, nil, {})
	
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.Dorm_SetRoleList, RefreshPanel)
end

function OnDestroy()
	eventMgr:ClearListener()
end


function OnOpen()
	Refresh()
end

function Refresh()
	curBuildData = data
	
	RefreshPanel()
end

function RefreshPanel()
	SetItems()
	--num
	local cur, max = curBuildData:GetNum()
	CSAPI.SetText(txtNum, string.format("%s/%s", cur, max))
end


function SetItems()
	datas = curBuildData:GetRoleInfos()
	items = items or {}
	ItemUtil.AddItems("Matrix/MatrixSetRoleItem", items, datas, grid, OnItemClickCB, 1, curBuildData, function()
		ItemAnims()
	end)
end

function ItemAnims()
	if(isFirst) then
		return
	end
	isFirst = 1
	for i, v in ipairs(items) do
		local delay =(i - 1) * 20
		UIUtil:SetObjFade(v.clickNode, 0, 1, nil, 300, delay)
		local x1 = i * 20
		UIUtil:SetPObjMove(v.clickNode, x1, 0, 0, 0, 0, 0, nil, 200, delay)
	end
end

function OnItemClickCB(_type, data)
	if(_type == 1) then
		--打开驻员列表
		CSAPI.OpenView("DormSetRoleList", {curBuildData:GetID()})
	else
		--移除单个
		local ids = curBuildData:GetRoles()
		local newIds = {}
		for i, v in ipairs(ids) do
			if(v ~= data:GetID()) then
				table.insert(newIds, v)
			end
		end
		local info = {}
		info.id = curBuildData:GetID()
		info.roleIds = newIds	
		BuildingProto:BuildSetRole({info})
	end
end

--清空
function OnClickClear()
	local info = {}
	info.id = curBuildData:GetID()
	info.roleIds = {}
	BuildingProto:BuildSetRole({info})
end

function OnClickMask()
	view:Close()
end


