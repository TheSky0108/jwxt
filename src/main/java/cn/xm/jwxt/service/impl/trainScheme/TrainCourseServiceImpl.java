package cn.xm.jwxt.service.impl.trainScheme;

import cn.xm.jwxt.bean.trainScheme.TCourseBaseInfo;
import cn.xm.jwxt.bean.trainScheme.TrainCourse;
import cn.xm.jwxt.mapper.trainScheme.custom.TrainCourseCustomMapper;
import cn.xm.jwxt.service.trainScheme.TrainCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * @Author: qlq
 * @Description
 * @Date: 10:40 2018/4/24
 */
@Service
public class TrainCourseServiceImpl implements TrainCourseService {
    @Autowired
    private TrainCourseCustomMapper trainCourseCustomMapper;//培养方案课程手写的mapper
    @Override
    public boolean addTrainCourse(List<TrainCourse> trainCourses) throws SQLException {
        return false;
    }

    @Override
    public boolean addTrainCourseBatch(List<TrainCourse> trainCourses) throws SQLException {
        return trainCourseCustomMapper.addTrainCourseBatch(trainCourses)>0?true:false;
    }

    @Override
    public boolean deleteTrainCourseByTrainSchemeId(String trainSchemeId) throws SQLException {
        return false;
    }

    @Override
    public boolean deleteTrainCourseByCoureseTypeId(String courseTypeId) throws SQLException {
        return false;
    }

    @Override
    public boolean updateTrainCourseByID(String courseTypeId, List<TrainCourse> trainCourses) throws SQLException {
        return false;
    }

    @Override
    public Map<String, Object> getTrainCourseByTrainCourseId(int trainCourseId) throws SQLException {
        return null;
    }

    @Override
    public List<Map<String, Object>> getTrainCoursesByTrainId(String trainSchemeId) throws SQLException {
        return null;
    }

    @Override
    public List<TCourseBaseInfo> getCoursesBseInfoByCondition(Map condition) throws SQLException {
        return trainCourseCustomMapper.getCoursesBseInfoByCondition(condition);
    }

    @Override
    public List<Map<String, Object>> getTrainCoursesByCondition(Map<String, Object> condition) throws SQLException {
        return trainCourseCustomMapper.getTrainCoursesByCondition(condition);
    }
}
