package tyut.selab.schedule.controller;

import com.ruoyi.common.core.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import tyut.selab.schedule.domain.po.Schedule;
import tyut.selab.schedule.service.impl.UploadScheduleService;

import java.util.List;

/**
 * @author Big_bai on 2022/10/4
 */
@RestController
@RequestMapping("/selab/Schedule")
public class UploadController extends BaseController {
    @Autowired
    private UploadScheduleService uploadScheduleService;

    @PostMapping("/add")
    @PreAuthorize("@ss.hasAnyPermi('schedule:mine:upload')")
    public void uploadSchedule(List<Schedule> schedules){
        uploadScheduleService.insertSchedule(schedules,getUserId());

    }

}
