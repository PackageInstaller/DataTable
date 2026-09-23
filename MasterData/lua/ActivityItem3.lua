function Awake()
    c_MenuADItem = ComUtil.GetCom(icon, "MenuADItem")
end

-- {bool，desc,width, height}  true:图片  
function Refresh(_data, curData)
    data = _data
    isPNG = data[1]
    CSAPI.SetGOActive(txtDesc, not isPNG)
    CSAPI.SetGOActive(icon, isPNG)
    if (isPNG) then
        c_MenuADItem.width = data[3]
        c_MenuADItem.height = data[4]
        c_MenuADItem:SetImage(icon, "activityview", data[2]..".png", curData:GetBoardImgUrl())
    else
        CSAPI.SetText(txtDesc, data[2])
    end
end
