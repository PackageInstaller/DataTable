--detailsFunc:详情回调
function Refresh(_data,_elseData)
    this.data=_data;
    local c=this.index%2==0 and {0,0,0,26} or {152,152,152,26}
    CSAPI.SetImgColor(gameObject,c[1],c[2],c[3],c[4]);
    CSAPI.SetText(txt_name,_data.txt1);
    CSAPI.SetText(txt_num,_data.txt2);
    if _data.code1 then
        CSAPI.SetTextColorByCode(txt_name,_data.code1);
    end
    if _data.code2 then
        CSAPI.SetTextColorByCode(txt_num,_data.code2);
    end
    CSAPI.SetGOActive(btnDetail,_data.goods~=nil);
    CSAPI.SetGOActive(btnSwitch,_data.switchFunc~=nil)
end

function OnClickDetail()
    if this.data.detailsFunc then
        this.data.detailasFunc(this)
    else
        local goods=this.data.goods;
        if goods==nil then
            do return end
        end
        if goods:GetCfg().type==ITEM_TYPE.SKIN and goods:GetCfg().dy_value2 then
            OpenSearchView(goods:GetCfg().dy_value2);
        elseif goods:GetCfg().type==ITEM_TYPE.LIMITED_TIME_SKIN and goods:GetCfg().dy_arr then
            OpenSearchView(goods:GetCfg().dy_arr[1]);
        else
            UIUtil:OpenGoodsInfo(goods,2)
        end
    end
end

function OpenSearchView(id)
    if id then
        local isShowImg=false;
        local l2dOn=false;
        if g_FHXOpenSkin ~= true and this.data.commodity then --礼包中的皮肤没有对应的商品数据则默认不使用L2D
            isShowImg=this.data.commodity:IsShowImg();
            l2dOn=true
        end
        CSAPI.OpenView("RoleInfoAmplification2", {id, l2dOn,isShowImg},LoadImgType.Main)
    end
end

function OnClickSwitch()
    if this.data.switchFunc~=nil then
        this.data.switchFunc(this)
    end
end

function SetIndex(_id)
    this.index=_id;
end