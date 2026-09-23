local curID = nil
function OnOpen()
	curID = MatrixMgr:GetWarningLv()
	SetItems()
end

function SetItems()
	matrixDefenseItems = matrixDefenseItems or {}
	local cfgs = Cfgs.CfgBAssault:GetAll()
	-- for i = #cfgs, #matrixDefenseItems do
	-- 	CSAPI.SetGOActive(matrixDefenseItems[i].gameObject, false)
	-- end
	-- for i, v in ipairs(cfgs) do
	-- 	if(#matrixDefenseItems >= i) then
	-- 		CSAPI.SetGOActive(matrixDefenseItems[i].gameObject, true)
	-- 		matrixDefenseItems[i].Refresh(v, curID)
	-- 	else
	-- 		ResUtil:CreateUIGOAsync("Matrix/MatrixDefenseItem", grid, function(go)
	-- 			local item = ComUtil.GetLuaTable(go)
	-- 			item.SetClickCB(ItemClickCB)
	-- 			item.Refresh(v, curID)
	-- 			table.insert(matrixDefenseItems, item)
	-- 		end)
	-- 	end
	-- end
	ItemUtil.AddItems("Matrix/MatrixDefenseItem", matrixDefenseItems, cfgs, grid, ItemClickCB, 1, curID)
end

function ItemClickCB(_id)
	curID = _id
	SetItems()
end


--能否改变(不在预准备阶段)
function CheckCanChange()
	local cfg = Cfgs.CfgBAssault:GetByKey(curID)
	if(cfg and cfg.openTimes) then
		local timeData = TimeUtil:GetTimeHMS(TimeUtil:GetTime(), "*t")
		for i, v in ipairs(cfg.openTimes) do
			for k, m in ipairs(v) do
				if(timeData.hour < v[1] and(timeData.min * 60 + timeData.sec) >=(3600 - v[3])) then
					Tips.ShowTips(string.format(StringTips.tips12, v[3]))
					return false
				end
			end
		end
	end
	return true
end



function OnClickSure()
	if(curID == MatrixMgr:GetWarningLv()) then
		view:Close()
		return
	end
	
	local isIn = MatrixAssualtTool:CheckIsRun()
	if(isIn) then
		Tips.ShowTips(StringTips.tips13)
		view:Close()
		return
	end
	local warningLv = MatrixMgr:GetWarningLv()
	if(curID ~= MatrixMgr:GetWarningLv() and CheckCanChange()) then
		BuildingProto:SetWarningLv(curID)
		view:Close()
	end
end


function OnClickClose()
	view:Close()
end

function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
grid=nil;
btnSure=nil;
txtSure=nil;
view=nil;
end
----#End#----