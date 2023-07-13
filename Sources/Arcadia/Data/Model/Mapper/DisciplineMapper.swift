//
//  DisciplineMapper.swift
//  Arcadia
//
//  Created by João Santos Sena on 12/07/23.
//

extension DisciplineCompleteDTO {
    func asDisciplineData() -> DisciplineData {
        return DisciplineData(
            id: self.id,
            disciplineId: self.activity.id,
            name: self.activity.name,
            code: self.activity.code,
            program: self.activity.program,
            hours: self.activity.hours,
            department: self.activity.department?.name,
            classes: self.classes.items.map({ clazz in
                DisciplineClass(
                    id: clazz.id,
                    groupName: clazz.description,
                    type: clazz.type,
                    teacher: clazz.teachers.items.first?.person,
                    hours: clazz.groupDetails.hours,
                    program: clazz.groupDetails.program,
                    allocations: clazz.allocations?.items ?? [],
                    lectures: clazz.lectures?.items.map({ lecture in
                        Lecture(
                            ordinal: lecture.ordinal,
                            situation: lecture.situation,
                            date: lecture.date,
                            subject: lecture.subject,
                            materials: lecture.materials?.items.map({ material in
                                LectureMaterial(
                                    id: material.id,
                                    description: material.description,
                                    url: material.url.link.href)
                            }) ?? [])
                    }) ?? [])
            }),
            evaluations: self.evaluations?.items.map({ evaluation in
                ClassEvaluation(
                    name: evaluation.name,
                    grades: evaluation.grades.items.map({ grade in
                        ClassGrade(
                            ordinal: grade.ordinal,
                            name: grade.name,
                            nameShort: grade.nameShort,
                            date: grade.date,
                            weight: grade.weight,
                            value: grade.grade?.value)
                    }))
            }) ?? [],
            result: self.result)
    }
}
