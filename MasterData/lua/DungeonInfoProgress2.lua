local cfg = nil
local data = nil
local sectionData = nil
local slider = nil

function Awake()
    slider = ComUtil.GetCom(sliderPrograss, "Slider")
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then

    end
end

function SetTitle(str)
    CSAPI.SetText(txtTitle, str)
end

function SetProgress(cur, max)
    CSAPI.SetText(txtPrograss, math.floor(cur / max * 10000 + 0.5) / 100 .. "%")
    slider.value = cur / max
end
