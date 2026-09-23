--背包强化装备逻辑
local this={}
local root=nil;
local data=nil;
local stuffList=nil;
function this.SetData(_root,_data)
    root=_root;
    data=_data;
    stuffList = StuffArray.New();
	for k,v in ipairs(data.stuffList:GetStuffArr()) do
        local num=v.num or 1;
        for i=1,num do
		    stuffList:AddStuffItem(v.data,v.type);
        end
    end
end

function this.Refresh()
    list = EquipMgr:GetStrengthList(data.cid);
    root.Refresh(list);
end

-- function this.GetScreenDataType()
--     return EquipViewKey.Strength;
-- end

function this.GetElseData(_data)
    local stuffInfo=stuffList:GetStuffByID(_data:GetID());
    local isSelect = false;
    local selectNum=0;
    local _selectType=_data:GetType()==EquipType.Material and 2 or 1;
    if stuffInfo~=nil then
        isSelect=true;
        selectNum=stuffInfo.num==nil and 1 or stuffInfo.num;
    end
    return  {isClick = true, isSelect = isSelect,selectType=_selectType,num=selectNum,showNew=true,isRemove=true, removeFunc = this.OnClickRemoveStuff};
end

function this.OnClickGrid(tab)
    if tab.data:IsNew() then
		EquipProto:SetIsNew({tab.data:GetID()}, function()
			tab.SetNewState(tab.data:IsNew());
		end);
    end
    local isSelect=tab.GetAddNum()>0;
    if tab.data:GetType()==EquipType.Material then
        this.AddStuffItem(tab);
    elseif tab.data:GetType()==EquipType.Normal then
        if isSelect then
            this.OnClickRemoveStuff(tab);
        else
            this.AddStuffItem(tab);
        end
    end
end

--往素材列表添加数据
function this.AddStuffItem(tab)
    if stuffList:GetStuffIsMax() == false and ((tab.GetAddNum()<tab.data:GetCount() and tab.data:GetType()==EquipType.Material) or tab.data:GetType()==EquipType.Normal) then
        stuffList:AddStuffItem(tab.data,tab.data:GetType()==EquipType.Material and 1 or 0);
        tab.SetChoosie(true);
        tab.SetAddNum(tab.GetAddNum()+1);
        root.SetSellPrice(stuffList.stuffCount,0,0);
    else
        Tips.ShowTips(LanguageMgr:GetTips(16003));
    end
end

--移除选中的素材
function this.OnClickRemoveStuff(tab)
    if stuffList then
        stuffList:RemoveStuffItem(tab.data:GetID(), 1);
        root.SetSellPrice(stuffList.stuffCount,0,0);
	end
    local currNum=tab.GetAddNum()-1<=0 and 0 or tab.GetAddNum()-1
    tab.SetAddNum(currNum);
	tab.SetChoosie(currNum>0);
end

function this.OnClickReturn()
    stuffList=data.stuffList;
    this.OnClickChoosie();
end

function this.OnClickChoosie()
    if not data.isBag then
        root.Close();
    end
    EventMgr.Dispatch(EventType.Equip_Stuff_SelectOver, stuffList);
    root.ChangeLayout(BagMgr:GetSelChildTabIndex(),EquipBagType.Normal,BagType.Equipped);
end

return this;